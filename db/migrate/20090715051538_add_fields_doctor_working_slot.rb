class AddFieldsDoctorWorkingSlot < ActiveRecord::Migration
  def self.up
    add_column :doctor_working_slots, :slots, :string
    add_column :deactivate_slots, :slots, :string
    rename_column :doctor_working_slots , :slot, :start_time
  end

  def self.down
  end
end
