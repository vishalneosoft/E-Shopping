class AddAvatarToBanners < ActiveRecord::Migration
  def change
    add_column :banners, :avatar, :string
  end
end
