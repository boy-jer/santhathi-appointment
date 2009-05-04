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
  has_one :clinical_screen

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
aasm_column :state

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

  def self.date_wise_report(from,to,option)
  	 condition = {}
  	 condition[:appointment_date] = from..to
  	 reports = Appointment.count(:conditions => condition , :group=>"appointment_date") if option == "day"
    return reports
  end

  def self.count_appointment(from,to)
  	temp =  Appointment.find(:all,:conditions => ["appointment_date BETWEEN ? AND ?",from,to]).size
  	return temp
  end

  def self.count_department_appointment(from,to,department)
  	 condition = {}
  	 if department =="All"
  	 	department_ids = Department.find(:all).map{ |department| department.id }
  	 	condition[:appointment_date] = from..to
     	condition[:department_id] = department_ids
  	else
 	   condition[:appointment_date] = from..to
       condition[:department_id] = department
	end
	 temp = Appointment.find(:all , :conditions => condition ).size
  	 return temp
  end

  def self.visit_type(from,to,visit_type)
  	condition = {}
  	condition[:appointment_date] = from..to
  	condition[:visit_type] = visit_type
  	reports = Appointment.count(:conditions => condition,:group=>"appointment_date")
  	return reports

  end

  def self.departament_report(from,to,department_id)
  	 condition = {}
      if department_id == "All"
  	     department_ids = Department.find(:all).map{ |department| department.id }
  	     condition[:appointment_date] = from..to
  	  else
  	  	condition[:appointment_date] = from..to
  	  	condition[:department_id] = department_id
      end
      reports = Appointment.count(:conditions => condition ,:group => "appointment_date")
      return reports

  end

  def self.doctor_report(from,to,doctor_id)
  	reports =  {}
  	condition = {}
  	  if doctor_id == "All"
  	  	condition[:appointment_date] = from..to
      else
      	condition[:appointment_date] = from..to
      	condition[:doctor_id] = doctor_id
      end
      temp_list = Appointment.find(:all, :select => "count('id') as count, appointment_date, doctor_id", :order => 'appointment_date', :group =>"appointment_date, doctor_id", :conditions =>condition)

     temp_list.map{|r| reports["#{r.appointment_date}$#{r.doctor_id}"] = {r.doctor_id => r.count} }
     return reports
  end

  def self.count_doctor_appointment(from,to,doctor_id)
     counts = {}
     condition = {}
  	 if doctor_id == "All"
  	   condition[:appointment_date] = from..to
 	 else
 	   condition[:appointment_date] = from..to
 	   condition[:doctor_id] = doctor_id
 	 end
 	 Appointment.count(:group =>"appointment_date", :conditions => condition ).map{|c| counts[c[0]] = c[1] }
	 return counts

  end

  def self.count_doctor_appointments(from,to,doctor)
  	 condition = {}
  	 if doctor =="All"
  	 	condition[:appointment_date] = from..to
     else
 	    condition[:appointment_date] = from..to
      	condition[:doctor_id] = doctor
 	end
 	 temp = Appointment.find(:all, :conditions => condition ).size
  	 return temp
  end

  def self.mode_report(from,to)
  	 reports = {}
  	 condition = {}
  	 condition[:appointment_date] = from..to
  	 temp_list = Appointment.find(:all, :select => "count('id') as count, appointment_date, mode_id", :order => 'appointment_date', :group =>"appointment_date, mode_id", :conditions => condition)
     temp_list.map{|r| reports["#{r.appointment_date}$#{r.mode_id}" ] = {r.mode_id => r.count} }
     return reports

  end


end
