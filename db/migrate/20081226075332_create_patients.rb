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

   f = File.open("#{RAILS_ROOT}/config/rashmi.csv","r")
   i = 0
   f.readlines.each do |record|
     record_split = record.split(",")
     if i >= 1
       registration_date = record_split[0]
       split_date = registration_date.split("-")
       reg_date = split_date[2] + '-' + split_date[0] + '-' + split_date[1]
       Patient.create(:reg_date => reg_date.to_date,:reg_no => record_split[1],:patient_name => record_split[2],:dob => record_split[6], :gender=>  record_split[8], :email =>record_split[17], :address => record_split[10], :contact_no => record_split[16],:spouse_name => record_split[22])
      end
     i = i + 1
    end


    Patient.find(:all).each do |p1|
      Patient.find(:all).each do |p2|
        if (p1.patient_name == p2.spouse_name) && (p2.spouse_name == p1.patient_name)
         p1.update_attributes(:spouse => p2.id)
         p2.update_attributes(:spouse => p1.id)
        end
      end
    end
 end
   


  def self.down
    drop_table :patients
  end
end
