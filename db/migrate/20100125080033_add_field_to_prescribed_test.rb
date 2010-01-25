class AddFieldToPrescribedTest < ActiveRecord::Migration
  def self.up
    rename_column :prescribed_tests, :lab_test_id, :service_id
    rename_column :sample_specfications, :lab_test_id, :service_id
    rename_column :parameter_specifications, :lab_test_id, :service_id
    rename_column :laboratory_reports, :lab_test_id, :service_id
    add_column    :services, :duration, :time
  end

  def self.down
  end
end
