class CreatePrescribedTests < ActiveRecord::Migration
  def self.up
    create_table :prescribed_tests do |t|
      t.integer :prescription_id
      t.integer :lab_test_id

      t.timestamps
    end
  end

  def self.down
    drop_table :prescribed_tests
  end
end
