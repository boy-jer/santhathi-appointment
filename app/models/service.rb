class Service < ActiveRecord::Base
  belongs_to :department
  belongs_to :account
  has_many :prescribed_tests
  has_many :prescriptions, :through => :prescribed_tests
  has_many :sample_specfications
  has_many :parameter_specifications , :order => "position"
  has_many :inventory_items_used_for_tests

  has_one :laboratory_report
  belongs_to :prescription

  acts_as_tree :order => "name"
  
  named_scope :lab_services, :conditions => ["department_id = ?", Department.find(:first, :select => :id, :conditions => "dept_name like '%Lab%'").id] 
  named_scope :top_level, :conditions => ["parent_id is null"]
end
