class CartItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  def self.calculate_total(cart_items,coupon)
    @coupon = Coupon.find_by(code: coupon)
    sub_total = 0
    cart_items.each do |item|
      sub_total += item.quantity * item.product.price
    end
    if @coupon.present?
      discount = (sub_total * @coupon.percent.to_i)/100
    else
      discount = 0
    end
    cart_total = sub_total - discount
    if cart_total < 5000
      shipping_cost = 50.to_f
    else
      shipping_cost = 0.to_f
    end
    [sub_total,shipping_cost,discount,cart_total]
  end
end
