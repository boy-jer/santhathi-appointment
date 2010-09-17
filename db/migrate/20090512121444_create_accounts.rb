class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :name
      t.references :account_group
      t.references :branch
      t.decimal :current_balance, :precision => 11, :scale => 2, :default => 0
      t.decimal :opening_balance, :precision => 11, :scale => 2
      t.timestamps
    end
    
    add_index :accounts, :account_group_id
    add_index :accounts, :branch_id
  end

  def self.down
    drop_table :accounts
  end
end
