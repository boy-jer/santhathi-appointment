class AddColumnToLbReport < ActiveRecord::Migration
  def self.up
    add_column :laboratory_reports, :prescribed_test_id, :integer
  end

  def self.down
    remove_clumn :laboratory_reports, :prescribed_test_id
  end
end
