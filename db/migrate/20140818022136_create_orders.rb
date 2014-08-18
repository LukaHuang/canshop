class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :address
      t.string :pay_status
      t.string :pay_type

      t.timestamps
    end
  end
end
