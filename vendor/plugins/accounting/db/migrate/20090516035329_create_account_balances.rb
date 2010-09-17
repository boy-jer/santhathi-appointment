class CreateAccountBalances < ActiveRecord::Migration
  def self.up
    create_table :account_balances do |t|
      t.references :account
      t.references :accounting_period
      t.references :accounting_day
      t.decimal :opening_balance, :precision => 11, :scale => 2
      t.decimal :closing_balance, :precision => 11, :scale => 2      
      t.date :for_date
      t.references :branch
      t.timestamps
    end
    
    add_index :account_balances, :account_id
    add_index :account_balances, :accounting_period_id
    add_index :account_balances, :branch_id
  end

  def self.down
    drop_table :account_balances
  end
end
