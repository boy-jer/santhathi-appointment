class CreateLabTests < ActiveRecord::Migration
  def self.up
    create_table :lab_tests do |t|
      t.string  :name
      t.time :duration
      t.string  :pre_requisites
      t.integer :parent_id
      t.integer :depth

      t.timestamps
    end
  end

  def self.down
    drop_table :lab_tests
  end
end
