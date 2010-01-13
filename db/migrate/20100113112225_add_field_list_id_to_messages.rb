class AddFieldListIdToMessages < ActiveRecord::Migration
  def self.up
     add_column :messages, :contact_list_id, :integer
  end

  def self.down
  end
end
