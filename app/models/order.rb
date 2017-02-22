class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :address
  has_many :order_items, dependent: :destroy
  has_many :track_orders, dependent: :destroy
  default_scope { order(:created_at => :desc) }
  has_one :used_coupon
  after_update :track_order_list

  def track_order_list
    self.track_orders.create(status: status)
  end
end
