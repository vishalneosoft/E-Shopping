class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :country
      t.integer :pincode
      t.integer :phone
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
