class Product < ActiveRecord::Base
  belongs_to :groups
  belongs_to :owner, :class_name => "User", :foreign_key => :user_id
  has_many :user_products
  has_many :beneed, :through => :user_products, :source => :user
  has_many :product_photos
  mount_uploader :photo, ProductUploader
  validates :name, :presence => true
  accepts_nested_attributes_for :product_photos, allow_destroy: true
  def editable_by?
    user && user == owner
  end

end
