class CreateTrackOrders < ActiveRecord::Migration
  def change
    create_table :track_orders do |t|
      t.string :status
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
