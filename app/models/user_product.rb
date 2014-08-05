class UserProduct < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  
  def name
    self.product.name
  end

  def price
    self.product.price
  end

  def product_id
    self.product.id
  end
end
