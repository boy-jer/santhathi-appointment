class AddStatusColToPayment < ActiveRecord::Migration
  def self.up
    add_column :payments, :state, :string
  end

  def self.down
    remove_column :payments, :state
  end
end
