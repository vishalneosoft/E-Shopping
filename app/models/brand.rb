class Brand < ActiveRecord::Base
  has_many :brand_categories, dependent: :destroy
  has_many :categories,through: :brand_categories
  has_many :products, dependent: :destroy
end
