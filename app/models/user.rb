class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :groups
  has_many :products
  has_many :group_users
  has_many :join_group, :through => :group_users, :source => :group
  has_many :user_products , dependent: :destroy
  has_many :cart, :through => :user_products, :source => :product

  after_create :assign_default_role

  
  def join!(group)
    join_group << group
  end
  def quit!(group)
    join_group.delete(group)
  end
  def is_member_of?(group)
    join_group.include?(group)
  end
  def want!(product)
    cart << product
  end
  def not_like!(product)
    cart.delete(product)
  end
  def is_want?(product)
    cart.include?(product)
  end
  def active_for_authentication? 
    super && approved? 
  end
  def inactive_message 
    if !approved? 
      :not_approved 
    else 
      super # Use whatever other message 
    end 
  end
  def assign_default_role
    add_role(:customer)
    approved
  end
end
