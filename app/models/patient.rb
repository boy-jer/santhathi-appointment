class Patient < ActiveRecord::Base
  has_many :appointments

  has_many :vital_signs
  has_many :registration_summaries ,:through => :vital_signs

 # has_one :discharge_summary
 # has_one :next_appointment_remark
 # has_one :clinical_comment


  validates_presence_of :patient_name, :contact_no

  #before_save :generate_reg_no

  named_scope :name_filter, lambda{|name| {:conditions => ["patient_name like ?", name]}}
  named_scope :todays, {:select => 'count(id) as tot_count', :conditions => ["created_at > ?", Time.now - 1.day]}


  def generate_reg_no
    count = "%04d" % (Patient.todays.first.tot_count.to_i + 1).to_s
    self.write_attribute(:reg_no, "#{Date.today.year.to_s.last(2)}#{"%02d" % Date.today.month}#{"%02d" % Date.today.day}#{count}")
  end
end
