class Parameter < ActiveRecord::Base
  belongs_to :measurement_unit
  has_many :parameter_specifications

  def self.parameter_list
     self.find(:all).collect{|para| [para.parameter_name, para.id]}
  end
end
