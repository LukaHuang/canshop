class Product < ActiveRecord::Base
  belongs_to :groups
  belongs_to :owner, :class_name => "User", :foreign_key => :user_id
  has_many :user_products
  has_many :beneed, :through => :user_products, :source => :user
  mount_uploader :photo, ProductUploader
  validates :name, :presence => true
  
  def editable_by?
    user && user == owner
  end

end
