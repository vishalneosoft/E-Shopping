class RemoveContentFromBanners < ActiveRecord::Migration
  def change
    remove_column :banners, :content, :string
  end
end
