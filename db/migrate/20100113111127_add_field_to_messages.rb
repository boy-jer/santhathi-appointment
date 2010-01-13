class AddFieldToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :contact_group_id, :integer
  end

  def self.down
    remove_column :messages, :contact_group_id
  end
end
