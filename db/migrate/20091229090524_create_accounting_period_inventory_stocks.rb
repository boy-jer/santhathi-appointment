class CreateAccountingPeriodInventoryStocks < ActiveRecord::Migration
  def self.up
    create_table :accounting_period_inventory_stocks do |t|
      t.references :inventory_item
      t.references :accounting_period
      t.references :branch
      t.integer :opening_stock
      t.integer :closing_stock
      t.decimal :opening_stock_value, :precision => 8, :scale => 2
      t.decimal :closing_stock_value, :precision => 8, :scale => 2
      t.timestamps
    end
  end

  def self.down
    drop_table :accounting_period_inventory_stocks
  end
end
