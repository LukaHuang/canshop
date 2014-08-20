# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  price       :integer
#  cost        :integer
#  number      :integer
#  created_at  :datetime
#  updated_at  :datetime
#  group_id    :integer
#  user_id     :integer
#  bargain     :integer          default(0)
#  special     :boolean          default(FALSE)
#  photo       :string(255)
#  snippet     :text
#  description :text
#

class Product < ActiveRecord::Base
  belongs_to :groups
  belongs_to :owner, :class_name => "User", :foreign_key => :user_id
  has_many :user_products
  has_many :beneed, :through => :user_products, :source => :user
  mount_uploader :photo, ProductUploader
  validates :name, :presence => true
  default_scope -> { order('name ASC') }
  def editable_by?
    user && user == owner
  end

end
