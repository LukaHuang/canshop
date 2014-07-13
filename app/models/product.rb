class Product < ActiveRecord::Base
  belongs_to :groups
  validates :name, :presence => true
end
