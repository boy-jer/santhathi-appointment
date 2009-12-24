class CreateAccountingPeriodAccountBalances < ActiveRecord::Migration
  def self.up
    create_table :accounting_period_account_balances do |t|
      t.references :account
      t.references :accounting_period
      t.references :branch
      t.decimal :opening_balance, :precision => 11, :scale => 2
      t.decimal :closing_balance, :precision => 11, :scale => 2
      t.timestamps
    end
  end

  def self.down
    drop_table :accounting_period_account_balances
  end
end
