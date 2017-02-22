class CheckOutsController < ApplicationController
  include CheckOutsHelper
  before_action :authenticate_user!
  before_action :set_total, only: [:index, :review_payment]

  # GET /check_outs
  # GET /check_outs.json
  def index
    @addresses = current_user.addresses
    @address = Address.new
  end

  def review_payment
    @address = Address.find(params[:address_id])
    # helper method review payment
    review_items(@address)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_total
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
    end

end
