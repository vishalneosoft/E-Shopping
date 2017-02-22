class CreateUsedCoupons < ActiveRecord::Migration
  def change
    create_table :used_coupons do |t|
      t.references :user, index: true, foreign_key: true
      t.references :order, index: true, foreign_key: true
      t.references :coupon, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
