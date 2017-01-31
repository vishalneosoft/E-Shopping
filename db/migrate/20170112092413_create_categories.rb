class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.boolean :status, :default => false
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
