class Department < ActiveRecord::Base
  has_many :doctors
  has_many :appointments
  has_many :services
  validates_presence_of :dept_name,:description
 validates_uniqueness_of :dept_name

  def self.departments_for_select_list
    self.find(:all).collect{|model| [model.dept_name, model.id]}
  end
end
