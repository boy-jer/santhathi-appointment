class CreateAccountGroupTypes < ActiveRecord::Migration
  def self.up
    create_table :account_group_types do |t|
      t.string :name
      t.string :description, :limit => 1000
      t.references :branch
      t.timestamps
    end
    
    add_index :account_group_types, :branch_id
  end

  def self.down
    drop_table :account_group_types
  end
end
