class AddAmountToCart < ActiveRecord::Migration
  def change
    add_column :user_products, :amount, :integer, :default => 1
  end
end
