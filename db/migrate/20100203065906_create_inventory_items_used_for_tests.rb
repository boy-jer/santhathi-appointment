class CreateInventoryItemsUsedForTests < ActiveRecord::Migration
  def self.up
    create_table :inventory_items_used_for_tests do |t|
      t.integer :service_id
      t.integer :inventory_item_id
      t.string  :quantity
      t.string  :comments

      t.timestamps
    end
  end

  def self.down
    drop_table :inventory_items_used_for_tests
  end
end
