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
  has_many :ca, :through => :user_products, :source => :product
  after_create :assign_default_role
  Item = Struct.new(:name, :product_id, :price, :amount)

  def cart
    sql = "select p.name, p.id,p.price, up.amount from user_products as up left join products as p on p.id = up.product_id where up.user_id = #{id}"
    @cart ||= ActiveRecord::Base.connection.execute(sql).to_a.each_with_object([]) do |it, sum|
      sum << Item.new(*it)
    end
  end 
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
    ca << product
  end
  def not_like!(product)
    ca.delete(product)
  end
  def is_want?(product)
    ca.include?(product)
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
