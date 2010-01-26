class PrescribedTest < ActiveRecord::Base
  belongs_to :prescription 
  has_one :laboratory_report
  belongs_to :service

  def prescribed_lab_tests

  end
end
