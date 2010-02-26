class LaboratoryReport < ActiveRecord::Base
  belongs_to :appointment
  belongs_to :prescribed_test
  #belongs_to :service
  has_many :laboratory_test_results, :order => :position 
end
