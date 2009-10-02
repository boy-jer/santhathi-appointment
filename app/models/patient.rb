class Patient < ActiveRecord::Base
  has_many :appointments

  has_many :vital_signs
  has_many :registration_summaries ,:through => :vital_signs

 # has_one :discharge_summary
 # has_one :next_appointment_remark
 # has_one :clinical_comment


  validates_presence_of :patient_name, :contact_no

  #before_save :generate_reg_no

  named_scope :name_filter, lambda{|name| {:conditions => ["patient_name like ? AND spouse is null ", "%#{name}%"] } }
  named_scope :contact_filter, lambda{|contact| {:conditions => ["contact_no = ? AND spouse is null ", "#{contact}"] } }
  named_scope :reg_no_filter, lambda{|reg_no| {:conditions => ["reg_no = ? AND spouse is null ", "#{reg_no}"] } }

  
  
  
  
  
  named_scope :todays, { :conditions => ["created_at > ? and reg_no is not null", (Time.now - 1.day).to_date]}


  def generate_reg_no
    count = "%04d" % (Patient.todays.count.to_i + 1).to_s
    self.write_attribute(:reg_no, Time.now.strftime('%y%m%d').to_s + count)
  end
end
