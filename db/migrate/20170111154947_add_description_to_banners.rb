class AddDescriptionToBanners < ActiveRecord::Migration
  def change
    add_column :banners, :content, :text
  end
end
