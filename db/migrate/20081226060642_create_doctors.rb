class CreateDoctors < ActiveRecord::Migration
  def self.up
    create_table :doctors do |t|
      t.integer :department_id
      t.string :doctor_name
      t.string :designation
      t.string :medical_id
      t.time :working_from
      t.time :working_to
      t.string :comments

      t.timestamps
    end
  end

  def self.down
    drop_table :doctors
  end
end
