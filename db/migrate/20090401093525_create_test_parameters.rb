class CreateTestParameters < ActiveRecord::Migration
  def self.up
    create_table :test_parameters do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :test_parameters
  end
end
