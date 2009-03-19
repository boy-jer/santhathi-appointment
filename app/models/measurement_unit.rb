class MeasurementUnit < ActiveRecord::Base
  has_one :parameter

  def self.mesurement_units
    self.find(:all).collect{|mu| [mu.name, mu.id]}
  end
end
