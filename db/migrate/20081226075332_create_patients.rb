class CreatePatients < ActiveRecord::Migration
  def self.up
    create_table :patients do |t|
      t.date :reg_date
      t.string :patient_name
      t.string :age
      t.string :reg_no
      t.date :dob
      t.string :gender
      t.string :spouse_name
      t.integer :spouse
      t.string :address
      t.string :contact_no
      t.string :reg_type

      t.timestamps
    end
  end

  def self.down
    drop_table :patients
  end
end
