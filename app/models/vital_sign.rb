class VitalSign < ActiveRecord::Base
	belongs_to :patient
	belongs_to :registration_summary
end
