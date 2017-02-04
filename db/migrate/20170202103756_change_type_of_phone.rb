class ChangeTypeOfPhone < ActiveRecord::Migration
  def change
    change_column :addresses, :phone, :string
  end
end
