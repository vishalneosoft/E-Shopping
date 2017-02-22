class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :address
  has_many :order_items, dependent: :destroy
  has_many :track_order, dependent: :destroy
  default_scope { order(:created_at => :desc) }
  has_one :used_coupon
  after_update :track_order_list

  def track_order_list
    @order = Order.find(id)
    @track_order = TrackOrder.new(status: @order.status,order_id: @order.id)
    @track_order.save
  end
end
