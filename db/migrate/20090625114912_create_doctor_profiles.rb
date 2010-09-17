class CreateDoctorProfiles < ActiveRecord::Migration
  def self.up
    create_table :doctor_profiles do |t|
    	t.integer :department_id
    	t.integer :doctor_id
      t.string :name
      t.string :designation
      t.string :medical_id
      t.time :working_from
      t.time :working_to
      t.string :comments

      t.timestamps
    end
  end

  def self.down
    drop_table :doctor_profiles
  end
end
