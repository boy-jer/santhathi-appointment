class ChangeInvItemsUsedForTestQuantity < ActiveRecord::Migration
  def self.up
    change_column :inventory_items_used_for_tests, :quantity, :decimal, :precision => 11, :scale => 2
  end

  def self.down
    change_column :inventory_items_used_for_tests, :quantity, :string
  end
end
