class AddDepartmentToPrescribedTest < ActiveRecord::Migration
  def self.up
     add_column :prescribed_tests ,:department_id ,:integer
     remove_column :prescriptions ,:department_id
  end

  def self.down
  end
end
