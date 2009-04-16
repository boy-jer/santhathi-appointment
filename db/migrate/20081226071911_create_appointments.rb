class CreateAppointments < ActiveRecord::Migration
  def self.up
    create_table :appointments do |t|
      t.integer :department_id
      t.integer :doctor_id
      t.integer :patient_id
      t.integer :reason_id
      t.date :appointment_date
      t.time :appointment_time
      t.string :state
      t.integer :mode_id

      t.timestamps
    end
  end

  def self.down
    drop_table :appointments
  end
end
