class PatientAppointmentsController < ApplicationController
  layout 'admin'
  # GET /doctor_appointments
  # GET /doctor_appointments.xml
  def index
   @patient = Patient.find(params[:patient_id])
   @appointments =  @patient.appointments

   respond_to do |format|
      format.html # show.html.erb
      format.js  {  render :layout => false }
    end
  end
end
