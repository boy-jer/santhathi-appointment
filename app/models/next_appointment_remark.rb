class NextAppointmentRemark < ActiveRecord::Base
  attr_accessor :hour, :minute
	belongs_to :appointment
	#belongs_to :patient



end

