class Department < ActiveRecord::Base
  has_many :doctors
  has_many :appointments

  def self.departments_for_select_list
    self.find(:all).collect{|model| [model.dept_name, model.id]}
  end
end
