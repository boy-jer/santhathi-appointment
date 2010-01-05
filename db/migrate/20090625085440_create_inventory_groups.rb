class CreateInventoryGroups < ActiveRecord::Migration
  def self.up
    create_table :inventory_groups do |t|
      t.string :name
      t.string :description
      t.references :branch
      t.timestamps
    end
  end

  def self.down
    drop_table :inventory_groups
  end
end
