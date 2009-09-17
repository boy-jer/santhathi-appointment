class DoctorWorkingSlot < ActiveRecord::Base
  serialize :slots, Array
	belongs_to :doctor
end
