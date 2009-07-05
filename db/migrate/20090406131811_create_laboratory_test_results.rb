class CreateLaboratoryTestResults < ActiveRecord::Migration
  def self.up
    create_table :laboratory_test_results do |t|
      t.string  :result
      t.string  :remarks
      t.integer :laboratory_report_id   
      t.integer :parameter_specification_id
      t.integer :position
      
      t.timestamps
    end
  end

  def self.down
    drop_table :laboratory_test_results
  end
end
