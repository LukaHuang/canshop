class AddColumnToProducts < ActiveRecord::Migration
  def change
    add_column :products, :snippet, :text
    add_column :products, :description, :text
  end
end
