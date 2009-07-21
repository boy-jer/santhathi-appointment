class LaboratoryReport < ActiveRecord::Base
  belongs_to :appointment
  belongs_to :prescription
  belongs_to :lab_test
  has_many :laboratory_test_results, :order => :position 
  
  named_scope :by_prescription_and_lab_test, lambda { |pr_id,lb_id| { :conditions => ["prescription_id = ? and lab_test_id = ?",pr_id,lb_id] } }
end
