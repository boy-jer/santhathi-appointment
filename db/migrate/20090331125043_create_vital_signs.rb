class CreateVitalSigns < ActiveRecord::Migration
  def self.up
    create_table :vital_signs do |t|
    	  t.integer :patient_id
    	  t.integer :registration_summary_id
    	  t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :vital_signs
  end
end
