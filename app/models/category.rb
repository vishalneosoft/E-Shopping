class Category < ActiveRecord::Base
  has_many :brand_categories, dependent: :destroy
  has_many :brands,through: :brand_categories
  has_many :sub_categories, class_name: "Category", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Category"
  has_many :product_categories, dependent: :destroy
  has_many :products,through: :product_categories
end
