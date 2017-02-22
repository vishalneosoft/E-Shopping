class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart_item, only: [ :show, :edit, :destroy]
  before_action :cart_sum, only: :index

  # GET /cart_items
  # GET /cart_items.json
  def index    
  end

  # GET /cart_items/1
  # GET /cart_items/1.json
  def show
  end

  # GET /cart_items/new
  def new
    @cart_item = CartItem.new
  end

  # GET /cart_items/1/edit
  def edit
  end

  # POST /cart_items
  # POST /cart_items.json
  def create
    quantity = 1
    if params[:product_show].present?
      quantity = params[:cart_item][:quantity].to_i
    end
    @product = Product.find(params[:product_id])
    @cart_item = CartItem.where(product_id: params[:product_id],user_id: current_user.id).first
    if @product.quantity>0
      if @cart_item.present?
        @cart_item.quantity += quantity 
      else
        @cart_item = CartItem.new(quantity: quantity,product_id: params[:product_id],user_id: current_user.id)
      end
      respond_to do |format|
        if @cart_item.save
          @cart_items = current_user.cart_items
          @create_msg = 'Item added to cart successfully'
          format.html { redirect_to :back, notice: 'Item added to cart successfully' }
          format.json { render :show, status: :created, location: @cart_item }
          format.js
        else
          format.html { render :new }
          format.json { render json: @cart_item.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to :back, alert: 'Product not available!' 
    end
  end

  # PATCH/PUT /cart_items/1
  # PATCH/PUT /cart_items/1.json
  def update
    @cart_total = 0
    @product = Product.find(params[:product_id])
    @cart_item = CartItem.find(params[:id])
    if params[:quantity_update] == "plus" && @product.quantity > 0
      @cart_item.quantity +=1
    elsif params[:quantity_update] == "minus" && @cart_item.quantity > 1
      @cart_item.quantity -=1
    elsif params[:quantity].present?
      @cart_item.quantity = params[:quantity].to_i
    end
    respond_to do |format|
      if @cart_item.save
        # method called cart_sum for cart total
        cart_sum
        @update_msg = 'Item successfully updated.'
        format.html { redirect_to :back, notice: 'Item successfully updated.' }
        format.json { render :show, status: :ok, location: @cart_item }
        format.js 
      else
        format.html { render :edit }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def apply_coupon
    @coupon = Coupon.find_by(code: params[:coupon])
    if @coupon.present?
      @coupon_used = UsedCoupon.find_by(user_id: current_user.id,coupon_id: @coupon.id)
      if @coupon_used.present?
        @coupon_msg = 'Coupon already used!..'
      else
        session[:coupon_applied] = params[:coupon]
      end
    else
      @coupon_msg = 'Invalid Coupon!..'
    end
    cart_sum
  end

  def remove_coupon
    if session[:coupon_applied].present?
      session[:coupon_applied] = nil
      cart_sum
    end
  end

  # DELETE /cart_items/1
  # DELETE /cart_items/1.json
  def destroy
    @cart_item.destroy
    # method called cart_sum for cart total
    cart_sum
    @delete_msg = "Item was successfully removed!"
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Item was successfully removed!' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def cart_sum
      @cart_items = current_user.cart_items
      cart_value = CartItem.calculate_total(@cart_items, session[:coupon_applied])
      @cart_total = cart_value[0]
      @shipping_cost = cart_value[1]
      @discount = cart_value[2]
      @cart_discount_total = cart_value[3]
    end

    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_item_params
      params.require(:cart_item).permit(:quantity, :user_id, :product_id)
    end
end
