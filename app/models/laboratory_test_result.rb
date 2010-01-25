class LaboratoryTestResult < ActiveRecord::Base
  belongs_to :appointment
  belongs_to :prescription
  belongs_to :service
  belongs_to :laboratory_report
  belongs_to :parameter_specification
  acts_as_list :scope => :laboratory_report
end
