module LaboratoryPrescriptionsHelper
=begin
	def test_prescribed(appointment)
       app_prescriptions = appointment.prescriptions.map{ |c| c.id }
       if app_prescriptions.nil?
       	  return
       end
       test_prescribed = Service.find(:all,
                                      :include => [:prescribed_tests,:prescriptions],
                                      :conditions => ["prescribed_tests.prescription_id IN (?)",app_prescriptions]
                                      ).map{ |p| p.name }.join(',')

       return test_prescribed
    end
=end

  def prescriptions_list(appointment)
  	  @prescription_list = appointment.prescriptions
  	  return @prescription_list
  end

  def dispaly_patient(appointment)
  	patient = appointment.patient
  	return patient
  end


end
