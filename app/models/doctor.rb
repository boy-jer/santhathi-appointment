class Doctor < ActiveRecord::Base
  has_many :appointments
  belongs_to :department
  before_save :update_time
  #has_many :time_slots
  attr_accessor :hour, :minute, :hour_to, :minute_to

  def update_time
    time1 = "#{hour}:#{minute}"
    write_attribute(:working_from, time1) unless time1.blank?
    time2 = "#{hour_to}:#{minute_to}"
    write_attribute(:working_to, time2) unless time2.blank?
  end
end
