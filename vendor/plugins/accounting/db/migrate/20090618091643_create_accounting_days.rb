class CreateAccountingDays < ActiveRecord::Migration
  def self.up
    create_table :accounting_days do |t|      
      t.references :branch
      t.references :accounting_period
      t.date :for_date
      t.string :state
      t.timestamps
    end
  end

  def self.down
    drop_table :accounting_days
  end
end
