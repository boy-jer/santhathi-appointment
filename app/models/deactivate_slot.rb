class DeactivateSlot < ActiveRecord::Base
	# validates_presence_of :reason_for_absence
	 belongs_to :doctor
end
