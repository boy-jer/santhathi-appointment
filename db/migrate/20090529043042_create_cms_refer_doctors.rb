class CreateCmsReferDoctors < ActiveRecord::Migration
  def self.up
    create_table :refer_doctors do |t|
      t.date :reference_date
      t.text :remarks
      t.integer :doctor_id
      t.integer :appointment_id

      t.timestamps
    end
  end

  def self.down
    drop_table :refer_doctors
  end

end
