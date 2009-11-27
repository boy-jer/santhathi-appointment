class CreateAdminMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.text :message_body
      t.integer :user_id
      t.string  :number
      t.string  :status
      t.integer :sms_id
      t.timestamps
    end
  end

  def self.down
    drop_table :admin_messages
  end
end
