class PrescribedTest < ActiveRecord::Base
  belongs_to :lab_test
  belongs_to :prescription 
  has_one :laboratory_report
end
