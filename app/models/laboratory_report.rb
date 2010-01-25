class LaboratoryReport < ActiveRecord::Base
  belongs_to :appointment
  belongs_to :prescription
  belongs_to :service
  has_many :laboratory_test_results, :order => :position 
end
