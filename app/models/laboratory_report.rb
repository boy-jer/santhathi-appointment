class LaboratoryReport < ActiveRecord::Base
  belongs_to :appointment
  belongs_to :prescription
  belongs_to :lab_test
  has_many :laboratory_test_results
end
