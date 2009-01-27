class Appointment < ActiveRecord::Base
  include AASM
  before_save :update_time
  
  attr_accessor :hour, :minute
  
  belongs_to :doctor
  belongs_to :patient
  belongs_to :department
  
  aasm_column :state
  aasm_initial_state :new
  aasm_state :confirmed
  #aasm_state :read
  #aasm_state :closed
  
  aasm_event :confirm do
    transitions :to => :confirmed, :from => [:new]
  end

  #aasm_event :close do
    #transitions :to => :closed, :from => [:read, :new]
  #end


  
  validates_presence_of :doctor_id, :appointment_date, :minute, :hour
  
  named_scope :on_date,lambda { |date| { :conditions => ["appointment_date = ?", date ] } }  
  named_scope :on_time,lambda { |time| { :conditions => ["appointment_time = ?", time] } }
 
  def update_time
    time = "#{hour}:#{minute}"
    write_attribute(:appointment_time, time) unless time.blank?
  end
aasm_column :state
end
