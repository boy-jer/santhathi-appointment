class PrescribedTest < ActiveRecord::Base
  belongs_to :prescription 
  has_one :laboratory_report
  belongs_to :service

  named_scope :by_laboratory_dept, lambda { |laboratory_dept_id| {:conditions => ["department_id = ?", laboratory_dept_id]} }
  named_scope :by_other_dept, lambda { |laboratory_dept_id| {:conditions => ["department_id != ?", laboratory_dept_id]} }
  

  def prescribed_lab_tests

  end
end
