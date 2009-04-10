class Doctor < ActiveRecord::Base
  has_many :appointments
  belongs_to :department
  before_save :update_time
  validates_presence_of :department_id,:name,:designation

  #has_many :time_slots
  attr_accessor :hour, :minute, :hour_to, :minute_to

  def update_time
    time1 = "#{hour}:#{minute}"
    write_attribute(:working_from, time1) unless time1.blank?
    time2 = "#{hour_to}:#{minute_to}"
    write_attribute(:working_to, time2) unless time2.blank?
  end

  def self.doctors_list
    self.find(:all).collect{|doc| [doc.name, doc.id]}
  end

  def self.laboratory_docator_list
  	self.find(:all,:include => [:department],:conditions => ["departments.dept_name = ?","Laboratory"]).collect{|doc| [doc.name, doc.id]}
  end
end
