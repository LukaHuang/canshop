class Product < ActiveRecord::Base
  belongs_to :groups
  belongs_to :owner, :class_name => "User", :foreign_key => :user_id
  validates :name, :presence => true
  def editable_by?
    user && user == owner
  end
end
