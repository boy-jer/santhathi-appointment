class CreateAccountingPeriods < ActiveRecord::Migration
  def self.up
    create_table :accounting_periods do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.string :state
      t.references :branch    
      t.timestamps
    end
    
    add_index :accounting_periods, :start_date
    add_index :accounting_periods, :end_date    
    add_index :accounting_periods, :branch_id
  end

  def self.down
    drop_table :accounting_periods
  end
end
