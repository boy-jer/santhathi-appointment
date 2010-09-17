class CreateAccountGroups < ActiveRecord::Migration
  def self.up
    create_table :account_groups do |t|
      t.string :name
      t.string :description, :limit => 1000
      t.string :type
      t.integer :parent_id
      t.boolean :is_p_and_l_acct
      t.references :account_group_type      
      t.references :branch
      t.timestamps
    end
    
    add_index :account_groups, :parent_id
    add_index :account_groups, :account_group_type_id 
    add_index :account_groups, :branch_id
  end

  def self.down
    drop_table :account_groups
  end
end
