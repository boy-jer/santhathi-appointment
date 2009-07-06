class Doctor < User
  has_many :appointments
  has_one :refer_doctor
  belongs_to :department
  has_one :doctor_profile
  #has_one :departament , :through => :doctor_profiles

  aasm_state :inactive


  aasm_event :deactivate do
    transitions :to => :inactive, :from => [:pending, :active, :passive]
  end
   aasm_event :active do
    transitions :to => :active, :from => [:pending, :inactive, :passive]
  end
  	attr_accessor :hour, :minute, :hour_to, :minute_to

  #has_many :time_slots
 accepts_nested_attributes_for :doctor_profile


  def self.doctors_list
    self.find(:all).collect{|doc| [doc.doctor_profile.name, doc.id] }
  end






=begin
  aasm_state :passive


  aasm_event :deactivate do
    transitions :to => :active, :from => [:pending,  :passive]
  end
   aasm_event :active do
    transitions :to => :inactive, :from => [:pending, :inactive, :passive]
  end
=end
end
