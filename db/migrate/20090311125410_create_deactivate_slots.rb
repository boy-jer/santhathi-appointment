class CreateDeactivateSlots < ActiveRecord::Migration
  def self.up
    create_table :deactivate_slots do |t|
      t.integer :doctor_id
      t.date :from_date
      t.time :time_from
      t.string :reason_for_absence
      t.timestamps
    end
  end

  def self.down
    drop_table :deactivate_slots
  end
end
