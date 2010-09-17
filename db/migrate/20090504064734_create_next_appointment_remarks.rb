class CreateNextAppointmentRemarks < ActiveRecord::Migration
  def self.up
    create_table :next_appointment_remarks do |t|
      t.string :remarks
      t.integer :appointment_id
     # t.integer :patient_id

      t.timestamps
    end
  end

  def self.down
    drop_table :next_appointment_remarks
  end
end
