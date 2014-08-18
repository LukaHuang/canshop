class AddOrderToUserProdcuts < ActiveRecord::Migration
  def change
    add_column :user_products, :order_id, :integer
  end
end
