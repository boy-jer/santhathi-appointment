class ChangeInventoryQuantitiesColToDecimal < ActiveRecord::Migration
  def self.up
    change_column :inventory_items, :current_quantity, :decimal, :precision => 11, :scale => 2
    change_column :inventory_items, :opening_quantity, :decimal, :precision => 11, :scale => 2
    change_column :inventory_stocks, :opening_stock, :decimal, :precision => 11, :scale => 2
    change_column :inventory_stocks, :closing_stock, :decimal, :precision => 11, :scale => 2
    change_column :inventory_transaction_items, :quantity, :decimal, :precision => 11, :scale => 2
    change_column :inventory_transaction_items, :current_quantity, :decimal, :precision => 11, :scale => 2
    change_column :inventory_transaction_items, :inventory_opening_stock_quantity, :decimal, :precision => 11, :scale => 2
    change_column :inventory_transaction_items, :inventory_closing_stock_quantity, :decimal, :precision => 11, :scale => 2
  end

  def self.down
    change_column :inventory_items, :current_quantity, :integer
    change_column :inventory_items, :opening_quantity, :integer
    change_column :inventory_stocks, :opening_stock, :integer
    change_column :inventory_stocks, :closing_stock, :integer
    change_column :inventory_transaction_items, :quantity, :integer
    change_column :inventory_transaction_items, :current_quantity, :integer
    change_column :inventory_transaction_items, :inventory_opening_stock_quantity, :integer
    change_column :inventory_transaction_items, :inventory_closing_stock_quantity, :integer
  end
end
