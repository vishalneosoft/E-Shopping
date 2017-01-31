class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :title
      t.string :content
      t.string :status

      t.timestamps null: false
    end
  end
end
