class DoctorProfile < ActiveRecord::Base
	belongs_to :doctor
#	belongs_to :departament
	before_save :update_time
	validates_presence_of :department_id, :name ,:designation


	attr_accessor :hour, :minute, :hour_to, :minute_to
	#attr_accessible :name ,:department_id ,:medical_id,:designation ,:comments

  def update_time
    time1 = "#{hour}:#{minute}"
    write_attribute(:working_from, time1) unless time1.blank?
    time2 = "#{hour_to}:#{minute_to}"
    write_attribute(:working_to, time2) unless time2.blank?
  end


end
