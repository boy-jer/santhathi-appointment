module ClinicalScreensHelper
	def last_visit(patient_id)
		last_visit = Appointment.find(:all,:order =>'created_at ASC',:conditions => ['patient_id = ?',patient_id]).map { |a| a.id}

		return last_visit.last-1

    end
end
