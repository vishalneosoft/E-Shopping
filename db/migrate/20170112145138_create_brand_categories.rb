class CreateBrandCategories < ActiveRecord::Migration
  def change
    create_table :brand_categories do |t|
      
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
