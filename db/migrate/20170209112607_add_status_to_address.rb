class AddStatusToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :status, :string
  end
end
