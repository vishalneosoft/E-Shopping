class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.references :address, index: true, foreign_key: true
      t.string :transaction_id
      t.string :status
      t.string :grand_total
      t.string :shipping_charge
      t.integer :payment_gateway_id

      t.timestamps null: false
    end
  end
end
