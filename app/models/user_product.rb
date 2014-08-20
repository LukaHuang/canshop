# == Schema Information
#
# Table name: user_products
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  product_id :integer
#  created_at :datetime
#  updated_at :datetime
#  amount     :integer          default(1)
#  order_id   :integer
#

class UserProduct < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  belongs_to :order
end
