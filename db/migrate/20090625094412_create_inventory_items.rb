class CreateInventoryItems < ActiveRecord::Migration
  def self.up
    create_table :inventory_items do |t|
      t.references :branch    
      t.string :name
      t.decimal :unit_buy_price, :precision => 11, :scale => 2

      t.decimal :unit_sale_price, :precision => 11, :scale => 2
      t.decimal :unit_sale_net_price, :precision => 11, :scale => 2
      t.decimal :unit_sale_vat_price, :precision => 11, :scale => 2

      t.decimal :sub_unit_sale_price, :precision => 11, :scale => 2
      t.decimal :sub_unit_sale_net_price, :precision => 11, :scale => 2
      t.decimal :sub_unit_sale_vat_price, :precision => 11, :scale => 2

      t.decimal :vat_percent, :precision => 2, :scale => 2

      t.references :inventory_group
      t.boolean :consumable
      t.boolean :discount_allowed
      t.references :inventory_unit_of_measurement
      t.integer :current_quantity, :default => 0
      t.integer :opening_quantity
      t.string  :shelf_no
      t.timestamps
    end
    
    add_index :inventory_items, :branch_id
    add_index :inventory_items, :inventory_group_id
  end

  def self.down
    drop_table :inventory_items
  end
end
