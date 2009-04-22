class LabTest < ActiveRecord::Base
  acts_as_tree :order => "name"

  has_many :sample_specfications
  has_many :parameter_specifications , :order => "position"
  has_one :laboratory_report
end
