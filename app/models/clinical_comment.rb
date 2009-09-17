class ClinicalComment < ActiveRecord::Base
	belongs_to :appointment
	#belongs_to :patient
end
