class Group < ActiveRecord::Base
  has_many :products
  validates :title, :presence => true
  belongs_to :admin, :class_name => "User", :foreign_key => :user_id
  def editable_by?(user)
    user && user == admin
  end
end
