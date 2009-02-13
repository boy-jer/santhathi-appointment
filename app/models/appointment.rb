class Appointment < ActiveRecord::Base
  include AASM
  before_save :update_time
  
  attr_accessor :hour, :minute
  
  belongs_to :doctor
  belongs_to :patient
  #belongs_to :department
  
  aasm_column :state
  aasm_initial_state :new_app

  aasm_state :new_app
  aasm_state :visited
  #aasm_state :read
  #aasm_state :closed
  
  aasm_event :mark_visited do
    transitions :to => :visited, :from => [:new_app]
  end

  #aasm_event :close do
    #transitions :to => :closed, :from => [:read, :new]
  #end

  validates_presence_of :doctor_id, :appointment_date, :minute, :hour
  
  named_scope :on_date, lambda { |date| { :conditions => ["appointment_date = ?", date ] } }
  named_scope :doctor_name, lambda { |doct| {:joins => :doctor, :conditions => ["doctors.id = ?", doct ] }} 
  named_scope :patient_name, lambda { |name| {:joins => :patient, :conditions => ["patients.patient_name like ? ", "%name%" ] }}
  named_scope :reg_no, lambda { |no| {:joins => :patient, :conditions => ["patient_name.reg_no like ? ", "no" ] }}
    
  named_scope :on_time,lambda { |time| { :conditions => ["appointment_time = ?", time] } }
 
  def update_time
    time = "#{hour}:#{minute}" unless hour.blank?
    write_attribute(:appointment_time, time) unless time.blank?
  end
aasm_column :state
end
