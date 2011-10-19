class CreateLaboratoryTestGroups < ActiveRecord::Migration
  def self.up
    create_table :laboratory_test_groups do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :laboratory_test_groups
  end
end
