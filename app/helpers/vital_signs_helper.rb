module VitalSignsHelper
=begin
	def reg_summary(patient_id,reg_summary_id)
		vitalsign = VitalSign.find(:first,
		                           :conditions => ['patient_id = ? AND registration_summary_id = ?',patient_id,reg_summary_id] )
		if vitalsign.nil?
			return
	    else
			return vitalsign.value
		end

	end
=end

   def reg_summary(vital_signs,reg_summary_id)
      value = nil
   	  for vital_sign in vital_signs
     	 if	vital_sign.registration_summary_id == reg_summary_id
   	  	   value = vital_sign.value
         end
  	  end

  	  if value.nil?
  	   	 return
 	  else
         return value
      end
   end

end
