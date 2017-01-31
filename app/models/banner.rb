class Banner < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  has_many :pictures, as: :imageable
end
