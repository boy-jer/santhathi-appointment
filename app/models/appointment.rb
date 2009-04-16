class Appointment < ActiveRecord::Base
  include AASM
  before_save :update_time

  attr_accessor :hour, :minute

  belongs_to :doctor
  belongs_to :patient
  belongs_to :reason
  belongs_to :mode

  #belongs_to :department
  has_one :prescription
  has_many :laboratory_test_results

  validates_presence_of :doctor_id, :reason_id,:mode_id

  aasm_column :state
  aasm_initial_state :new_appointment

  aasm_state :new_appointment
  aasm_state :visited
  aasm_state :canceled
  aasm_state :recommend_for_discharge

  aasm_event :mark_visited do
    transitions :to => :visited, :from => [:new_appointment]
  end

  aasm_event :cancel do
    transitions :to => :canceled, :from => [:new_appointment]
  end

  aasm_event :recommend_for_discharge do
   transitions :to => :recommend_for_discharge,:from => [:visited]
  end

  validates_presence_of :doctor_id, :appointment_date, :minute, :hour

  named_scope :on_date, lambda { |date| { :conditions => ["appointment_date = ?", date ] } }
  named_scope :status, lambda { |state|{ :include => ['patient', 'reason', 'doctor'], :conditions => ["state = ?", state] } }

  named_scope :visited_and_discharge_recomonded, lambda { |state1, state2|{ :include => ['patient', 'reason', 'doctor'], :conditions => ["state = ? or state = ?",state1,state2] } }

  named_scope :doctor_name, lambda { |doct| {:joins => :doctor, :conditions => ["doctors.id = ?", doct ] }}
  named_scope :patient_name, lambda { |name| {:joins => :patient, :conditions => ["patients.patient_name like ?", '%'+ name +'%'] }}
  named_scope :reg_no, lambda { |reg| {:joins => :patient, :conditions => ["patients.reg_no like ? ", reg +'%'] }}

  named_scope :on_time,lambda { |time| { :conditions => ["appointment_time = ?", time] } }

  def update_time
    time = "#{hour}:#{minute}" unless hour.blank?
    write_attribute(:appointment_time, time) unless time.blank?
  end
aasm_column :state
end
