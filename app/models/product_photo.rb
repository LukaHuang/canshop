class ProductPhoto < ActiveRecord::Base
  belongs_to :product
  mount_uploader :photo, ProductPhotoUploader
end
