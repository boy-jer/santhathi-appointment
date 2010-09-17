class CreateDoctorWorkingSlots < ActiveRecord::Migration
  def self.up
    create_table :doctor_working_slots do |t|
      t.integer :doctor_id
      t.time :slot
      t.timestamps
    end
  end

  def self.down
    drop_table :doctor_working_slots
  end
end
