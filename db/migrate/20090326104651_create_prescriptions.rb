class CreatePrescriptions < ActiveRecord::Migration
  def self.up
    create_table :prescriptions do |t|
      t.date :p_date
      t.time :p_time
      t.integer :quantity
      t.string :urgency
      t.date :follow_up
      t.string :remarks
      t.integer :department_id
      t.integer :appointment_id

      t.timestamps
    end
  end

  def self.down
    drop_table :prescriptions
  end
end
