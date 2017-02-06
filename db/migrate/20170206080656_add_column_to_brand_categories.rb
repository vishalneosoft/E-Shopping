class AddColumnToBrandCategories < ActiveRecord::Migration
  def change
    add_reference :brand_categories, :brand, index: true, foreign_key: true
  end
end
