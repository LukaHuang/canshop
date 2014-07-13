class Group < ActiveRecord::Base

  belongs_to :admin, :class_name => "User", :foreign_key => :user_id
  has_many :products
  has_many :group_users
  has_many :members, :through => :group_users, :source => :user
  validates :title, :presence => true
  after_create :join_owner_to_group
  def editable_by?(user)
    user && user == admin
  end

  def join_owner_to_group
    members << admin
  end
end
