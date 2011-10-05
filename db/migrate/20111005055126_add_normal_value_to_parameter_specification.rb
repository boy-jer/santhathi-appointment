class AddNormalValueToParameterSpecification < ActiveRecord::Migration
  def self.up
     add_column :parameter_specifications, :normal_value, :string
  end

  def self.down
     remove_column :parameter_specifications, :normal_value
  end
end
