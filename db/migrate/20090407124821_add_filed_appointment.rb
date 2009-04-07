class AddFiledAppointment < ActiveRecord::Migration
  def self.up
  	add_column :appointments, :created_by_id, :integer
  	add_column :appointments, :updated_by_id, :integer
  end

  def self.down
  end
end
