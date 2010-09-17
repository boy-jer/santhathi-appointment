class CreateDischargeSummaries < ActiveRecord::Migration
  def self.up
    create_table :discharge_summaries do |t|
      t.date :preparation
      t.text :complaints
      t.text :symptoms
      t.text :treatment
      t.text :treatment_result
      t.text :remarks
      t.integer :appointment_id
    #  t.integer :patient_id

      t.timestamps
    end
  end

  def self.down
    drop_table :discharge_summaries
  end
end
