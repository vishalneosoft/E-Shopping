class CreateCheckOuts < ActiveRecord::Migration
  def change
    create_table :check_outs do |t|

      t.timestamps null: false
    end
  end
end
