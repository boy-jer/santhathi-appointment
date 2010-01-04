class CreateAdminSavedMessages < ActiveRecord::Migration
  def self.up
    create_table :saved_messages do |t|
      t.string :title
      t.string :description
      t.string :content

      t.timestamps
    end
  end

  def self.down
    drop_table :admin_saved_messages
  end
end
