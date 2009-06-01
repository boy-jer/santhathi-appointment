class Pms::PatientAppointmentsController < ApplicationController
  layout 'admin'

  def index
=begin
   unless params[:appointment_id].blank?
   	 appointment =  Appointment.find(params[:appointment_id])
   	 params[:patient_id] = appointment.patient.id
   end
=end
   @patient = Patient.find(params[:patient_id])
   @appointments =  @patient.appointments
   render :layout => false
  end
end
