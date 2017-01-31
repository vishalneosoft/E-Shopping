class AddAvatarToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :avatar, :string
  end
end
