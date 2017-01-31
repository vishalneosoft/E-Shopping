class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :sku
      t.string :short_description
      t.text :long_description
      t.float :price
      t.boolean :status, :default => false
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
