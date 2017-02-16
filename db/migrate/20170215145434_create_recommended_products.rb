class CreateRecommendedProducts < ActiveRecord::Migration
  def change
    create_table :recommended_products do |t|
      t.integer :product_id
      t.integer :recommended_product_id
    end
  end
end
