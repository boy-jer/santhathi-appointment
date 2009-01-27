class CreateTimeSlots < ActiveRecord::Migration
  def self.up
    create_table :time_slots do |t|
      t.datetime :schedule_date
      t.time  :start_time
      t.integer :doctor_id
      t.integer :patient_id
      t.timestamps
    end
  end

  def self.down
    drop_table :time_slots
  end
end
