class Parameter < ActiveRecord::Base
  serialize :multi_values, Array
  belongs_to :measurement_unit
  has_many :parameter_specifications
  has_many :parameter_values
  
  def self.parameter_list
     self.find(:all).collect{|para| [para.parameter_name, para.id]}
  end
end
