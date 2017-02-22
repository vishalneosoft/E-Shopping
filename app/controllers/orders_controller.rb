class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :cart_total, only: [:create]

  def index
    @orders = current_user.orders
  end

  def new
  end

  def payment
    @order = Order.find(params[:id])
  end

  def show
    if current_user.orders.pluck(:id).include?(params[:id].to_i)
      @order = Order.find(params[:id])
      @address = @order.address
      @orderitems = @order.order_items
    else 
      redirect_to root_path, alert: 'Sorry you dont have such order.'
    end
  end

  def create
    if current_user.orders.find_by(status: 'pending').present?
      @order = current_user.orders.find_by(status: 'pending')
      @order.update(order_params)
      redirect_to payment_order_path(@order)
    else
      @order = Order.new(order_params)
      if @order.save
        redirect_to payment_order_path(@order)
      else
        redirect_to :back
      end
    end
  end

  def create_charges
    # Amount in cents
    @order = Order.find(params[:id])
    @amount = @order.grand_total.to_i*100

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'inr'
    )
    if params[:stripeToken].present?
      @order.update(status: 'success',transaction_id: params[:stripeToken])
    end
    @transaction = Transaction.new(charge: charge[:customer],charge_id: charge[:id],amount: charge[:amount],stripetoken: params[:stripeToken],stripeemail: params[:stripeEmail],order_id: params[:id])
    @transaction.save
    @cart_items = current_user.cart_items
    @cart_items.each do |cart_item|
      @product = Product.find(cart_item.product_id)
      @product.quantity -= cart_item.quantity
      @product.save
      @order_item = OrderItem.new(order_id: params[:id],product_id: cart_item.product_id,quantity: cart_item.quantity,
        user_id: current_user.id,amount: (cart_item.product.price*cart_item.quantity))
      @order_item.save
    end
    @coupon = Coupon.find_by(code: session[:coupon_applied])
    @coupon_used = UsedCoupon.new(user_id: current_user.id,order_id: params[:id],coupon_id: @coupon.id)
    @coupon_used.save
    session[:coupon_applied] = nil
    @cart_items.destroy_all
    @address = @order.address
    OrderMailer.order_email(current_user,@order,@address).deliver_now
    redirect_to order_path(params[:id])

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to payment_order_path(@order)
  end

  def cancel_order
    @order = Order.find(params[:id])
    @order.update(status: 'cancel')
    @transaction = Transaction.find_by(order_id: params[:id])
    charge = Stripe::Charge.retrieve(@transaction.charge_id)
    charge.refund
    @orderitems = @order.order_items
    @orderitems.each do |order_item|
      @product = Product.find(order_item.product_id)
      @product.quantity += order_item.quantity
      @product.save
    end
    OrderMailer.order_cancel_email(current_user,@order,@address).deliver_now
    redirect_to order_path(params[:id])
  end

  private

  def cart_total
    @coupon = Coupon.find_by(code: session[:coupon_applied])
    @cart_items = current_user.cart_items
    @sub_total = 0
    @cart_items.each do |item|
      @sub_total += item.quantity * item.product.price
    end
    if @coupon.present?
        @discount = (@sub_total * @coupon.percent.to_i)/100
    else
      @discount = 0
    end
    @cart_total = @sub_total - @discount
    if @cart_total < 5000
      @shipping_cost = 50.to_f
    else
      @shipping_cost = 0.to_f
    end
    @cart_tax=(0.15)*@cart_total
    @total=@cart_total+@cart_tax+@shipping_cost
  end

  def order_params
    { 
      user_id: current_user.id,
      address_id: params[:address_id],
      status: :pending,
      grand_total: @total,
      shipping_charge: @shipping_cost 
    }
  end
end
