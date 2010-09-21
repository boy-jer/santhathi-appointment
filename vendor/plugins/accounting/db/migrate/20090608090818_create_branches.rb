class CreateBranches < ActiveRecord::Migration
  def self.up
    create_table :branches do |t|
      t.string :name
      t.references :company
      t.integer :default_current_open_day_id
      t.timestamps
    end
    add_index :branches, :company_id
  end

  def self.down
    drop_table :branches
  end
end
