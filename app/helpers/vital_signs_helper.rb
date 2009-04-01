module VitalSignsHelper

	def reg_summary(patient_id,reg_summary_id)
		vitalsign = VitalSign.find(:first,
		                           :conditions => ['patient_id = ? AND registration_summary_id = ?',patient_id,reg_summary_id] )
		if vitalsign.nil?
			return
	    else
			return vitalsign.value
		end

	end
end
