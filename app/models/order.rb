# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  address    :string(255)
#  pay_status :string(255)
#  pay_type   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Order < ActiveRecord::Base
  belongs_to :customer, :class_name => "User", :foreign_key => :user_id
  has_many :user_products , dependent: :destroy
  validates :pay_type, :presence => true
  validates :get_type, :presence => true
  validates :address, :presence => true
  default_scope -> { order('created_at DESC') }
end
