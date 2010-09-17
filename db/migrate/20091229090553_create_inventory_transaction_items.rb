class CreateInventoryTransactionItems < ActiveRecord::Migration
  def self.up
    create_table :inventory_transaction_items do |t|
      t.references :branch
      t.references :accounting_day
      t.references :accounting_period
      t.references :inventory_item
      t.date       :transaction_date
      t.string     :narration, :limit => 1000
      t.string     :category #purchase, sale, returns, pure_inventory etc.
      t.string     :unit_type #is it a main-unitwise or a sub-unitwise sale? quantity and price cols below is based on this. Always main-unitwise for purchase. Can be main-unitwise or sub-unitwise for sale/return/damage etc.
      t.integer    :quantity
      t.decimal    :price
      t.decimal    :total_price, :precision => 11, :scale => 2
      t.decimal    :inventory_opening_stock_quantity
      t.decimal    :inventory_closing_stock_quantity

      #purchase specific columns
      t.integer    :current_quantity  # same as quantity but reduce this for each sale till it becomes 0 (necassary to calculate inventory value)

      #sales specific columns
      t.integer    :purchased_inventory_transaction_item_id #this id references the inventory_transaction_items table from which lot the sale occured using FIFO.
      t.decimal    :total_vat_price, :precision => 11, :scale => 2
      t.decimal    :total_item_price, :precision => 11, :scale => 2      
      t.timestamps
    end
  end

  def self.down
    drop_table :inventory_transaction_items
  end
end
