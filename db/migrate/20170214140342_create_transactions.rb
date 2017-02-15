class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :charge
      t.string :charge_id
      t.integer :amount
      t.string :stripetoken
      t.string :stripeemail
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
