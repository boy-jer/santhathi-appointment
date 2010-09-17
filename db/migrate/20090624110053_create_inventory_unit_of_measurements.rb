class CreateInventoryUnitOfMeasurements < ActiveRecord::Migration
  def self.up
    create_table :inventory_unit_of_measurements do |t|
      t.references :branch
      t.string  :unit_name
      t.string  :unit_symbol
      t.string  :sub_unit_name
      t.string  :sub_unit_symbol
      t.integer :unit_value
      t.timestamps
    end
  end

  def self.down
    drop_table :inventory_unit_of_measurements
  end
end
