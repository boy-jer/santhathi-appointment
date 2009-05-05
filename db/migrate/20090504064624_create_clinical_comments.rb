class CreateClinicalComments < ActiveRecord::Migration
  def self.up
    create_table :clinical_comments do |t|
      t.text :commet
      t.integer :appointment_id
      #t.integer :patient_id

      t.timestamps
    end
  end

  def self.down
    drop_table :clinical_comments
  end
end
