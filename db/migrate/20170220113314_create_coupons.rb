class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :code
      t.string :percent
      t.string :no_of_uses

      t.timestamps null: false
    end
  end
end
