class AddBargainAndSpecialToProduct < ActiveRecord::Migration
  def change
    add_column :products, :bargain, :integer, :default => 0
    add_column :products, :special, :boolean, :default => false
  end
end
