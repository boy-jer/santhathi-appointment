class LaboratoryTestResult < ActiveRecord::Base
  belongs_to :appointment
  belongs_to :prescription
  belongs_to :lab_test
  belongs_to :laboratory_report
end
