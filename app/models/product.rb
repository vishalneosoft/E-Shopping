class Product < ActiveRecord::Base
  has_many :pictures, as: :imageable
  belongs_to :brand
  has_many :product_categories
  has_many :categories,through: :product_categories
end
