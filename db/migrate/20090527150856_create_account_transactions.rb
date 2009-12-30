class CreateAccountTransactions < ActiveRecord::Migration
  def self.up
    create_table :account_transactions do |t|
      t.string :transaction_no
      t.date :transaction_date
      t.string :narrations, :limit => 5000
      t.references :accounting_period
      t.references :accounting_day
      t.references :branch
      t.string :type
      t.string :account_transactionable_on
      t.string :account_transactionable_type
      t.integer :account_transactionable_id 	
      t.timestamps
    end
    
    add_index :account_transactions, :accounting_period_id
    add_index :account_transactions, :branch_id
  end

  def self.down
    drop_table :account_transactions
  end
end
