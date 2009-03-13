class CreateDeactivateSlots < ActiveRecord::Migration
  def self.up
    create_table :deactivate_slots do |t|
      t.string :department
      t.string :doctor_name
      t.date :from_date
      t.date :to_date
      t.time :time_from
      t.time :time_to
      t.string :reason_for_absence

      t.timestamps
    end
  end

  def self.down
    drop_table :deactivate_slots
  end
end
