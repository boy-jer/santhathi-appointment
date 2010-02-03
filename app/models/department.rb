class Department < ActiveRecord::Base
  has_many :doctors
  has_many :appointments
  has_many :services
 # has_many :doctors , :through => :doctor_profiles
  #has_many :doctor_profiles

  validates_presence_of :dept_name, :description
  validates_uniqueness_of :dept_name

  def self.departments_for_select_list
    all_departments = [["Select department",""]]
    all_departments += self.find(:all).collect{|model| [model.dept_name, model.id]}
  end

  def self.departments_select_list_for_pms_report
    all_departments = [["All Departments","All"]]
    all_departments += Department.find(:all).collect{|model| [model.dept_name, model.id]}
  end

  def self.departments_for_select_list_without_lab
    all_departments = [["Select Department",  ""]]
    all_departments += Department.find(:all, :select => ["dept_name, id"]).collect{|dept| [dept.dept_name, dept.id] unless dept.dept_name.upcase =~ /LAB/}
    all_departments.compact
  end  
end
