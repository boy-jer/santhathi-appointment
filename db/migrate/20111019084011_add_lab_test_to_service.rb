class AddLabTestToService < ActiveRecord::Migration
  def self.up
    add_column :services,:lab_test,:boolean,:default => true
  end

  def self.down
  end
end
