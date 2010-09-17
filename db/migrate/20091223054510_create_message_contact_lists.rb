class CreateMessageContactLists < ActiveRecord::Migration
  def self.up
    create_table :message_contact_lists do |t|
      t.integer :message_id
      t.integer :contact_list_id
      t.integer :sms_id
      t.string :status,:default =>"Sent"

      t.timestamps
    end
  end

  def self.down
    drop_table :message_contact_lists
  end
end
