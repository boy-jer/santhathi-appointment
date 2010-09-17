class CreateAdminContactLists < ActiveRecord::Migration
  def self.up
    create_table :contact_lists do |t|
      t.integer:contact_group_id
      t.string :name
      t.string :contact_number

      t.timestamps
    end
  end

  def self.down
    drop_table :contact_lists
  end
end
