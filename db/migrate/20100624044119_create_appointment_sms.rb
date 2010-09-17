class CreateAppointmentSms < ActiveRecord::Migration
  def self.up
    create_table :appointment_sms do |t|
      t.integer :patient_id
      t.timestamps
    end
  end

  def self.down
    drop_table :appointment_sms
  end
end
