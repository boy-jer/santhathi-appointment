class AddAccountIdColToServicesInventory < ActiveRecord::Migration
  def self.up
    add_column :services, :account_id, :integer
    add_column :inventory_items, :account_id, :integer
  end

  def self.down
    remove_column :services, :account_id
    remove_column :inventory_items, :account_id
  end
end
