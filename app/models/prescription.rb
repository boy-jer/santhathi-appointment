class Prescription < ActiveRecord::Base

  belongs_to :appointment
  #belongs_to :department
  has_many :prescribed_tests
  has_many :services, :through => :prescribed_tests
  has_many :laboratory_test_results
  has_many :laboratory_reports
end
