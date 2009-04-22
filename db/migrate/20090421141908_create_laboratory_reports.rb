class CreateLaboratoryReports < ActiveRecord::Migration
  def self.up
    create_table :laboratory_reports do |t|
      t.integer :appointment_id
      t.integer :prescription_id
      t.integer :lab_test_id
      t.date :date_of_action
      t.time :time_of_action
      t.integer :action_taken_by_id
      t.integer :authorised_by_id
      t.string :description
      t.timestamps
    end
  end

  def self.down
    drop_table :laboratory_reports
  end
end
