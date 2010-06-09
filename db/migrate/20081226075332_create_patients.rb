class CreatePatients < ActiveRecord::Migration
  def self.up
    create_table :patients do |t|
      t.date :reg_date
      t.string :patient_name
      t.string :reg_no
      t.date :dob
      t.string :gender
      t.string :spouse_name
      t.integer :spouse
      t.string :email
      t.text :address
      t.string :contact_no
      t.string :reg_type

      t.timestamps
    end

   f = File.open("#{RAILS_ROOT}/config/file.csv","r")
   f.readlines.each do |record|
     record_split = record.split(",")
     Patient.create(:reg_date => record_split[0],:reg_no => record_split[1],:patient_name => record_split[2],:dob => record_split[6], :gender=>  record_split[8], :email =>record_split[17], :address => record_split[10], :contact_no => record_split[16])
    end
  end

  def self.down
    drop_table :patients
  end
end
