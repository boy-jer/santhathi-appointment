class InventoryUnitOfMeasurement < ActiveRecord::Base
  belongs_to :branch

  validates_presence_of :branch_id, :unit_name, :unit_value
  validates_numericality_of :unit_value, :allow_nil => true

  attr_accessible :unit_name, :unit_symbol, :sub_unit_name, :sub_unit_symbol, :unit_value
end
