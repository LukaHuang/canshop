class AddColumnToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :status, :string, :default => "待確認"
    add_column :orders, :extra, :text
  end
end
