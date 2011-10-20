class AddLaboratoryTestGroupToService < ActiveRecord::Migration
  def self.up
    add_column :services, :laboratory_test_group_id , :integer
  end

  def self.down
  end
end

