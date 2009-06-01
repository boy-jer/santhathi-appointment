class CreateCmsPharmacyPrescriptions < ActiveRecord::Migration
  def self.up
    create_table :pharmacy_prescriptions do |t|

       t.date :prescribing_date
       t.integer :course_duration
       t.text :other_remarks
       t.integer :quantity
       t.date :course_start_date
       t.time :time_of_prescription
       t.date :course_end_date



       t.references :appointment
       t.references :pharamacy_item_information
			 t.references :pharmacy_course_list
			 t.references :pharmacy_dosage_list
      t.timestamps
    end
  end

  def self.down
    drop_table :pharmacy_prescriptions
  end
end
