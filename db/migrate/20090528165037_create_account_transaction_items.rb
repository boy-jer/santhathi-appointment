class CreateAccountTransactionItems < ActiveRecord::Migration
  def self.up
    create_table :account_transaction_items do |t|
      t.references :accounting_period
      t.references :account_transaction
      t.references :account
      t.string     :category            
      t.decimal    :amount, :precision => 11, :scale => 2
      t.integer    :parent_id
      t.decimal    :account_opening_balance, :precision => 11, :scale => 2
      t.decimal    :account_closing_balance, :precision => 11, :scale => 2        
      t.date       :transaction_date
      t.string     :transaction_type, :limit => 1
      t.references :branch
      t.timestamps
    end
    
    add_index :account_transaction_items, :account_transaction_id
    add_index :account_transaction_items, :account_id    
    add_index :account_transaction_items, :branch_id
    add_index :account_transaction_items, :transaction_date
    add_index :account_transaction_items, :parent_id
    add_index :account_transaction_items, :transaction_type
    add_index :account_transaction_items, :category
  end

  def self.down
    drop_table :account_transaction_items
  end
end
