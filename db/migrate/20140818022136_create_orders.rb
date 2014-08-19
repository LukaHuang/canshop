class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id , :null => false
      t.string :address , :null => false
      t.string :pay_status, :default => "未付款"
      t.string :pay_type
      t.string :get_type

      t.timestamps
    end
  end
end
