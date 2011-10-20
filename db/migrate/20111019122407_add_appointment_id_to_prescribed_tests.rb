class AddAppointmentIdToPrescribedTests < ActiveRecord::Migration
  def self.up
    add_column :prescribed_tests , :appointment_id, :integer
    PrescribedTest.all.each do |pt|
       pt.update_attribute('appointment_id', pt.prescription.appointment_id)
    end
  end

  def self.down
    remove_column :prescribed_tests , :appointment_id
  end
end

