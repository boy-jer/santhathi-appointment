class DoctorPatientsController < ApplicationController
   layout 'cms'
  # GET /doctor_appointments
  # GET /doctor_appointments.xml
  def index
   doctor_id = (params[:doctor][:id] unless  params[:doctor].blank?) || (self.current_user.id if self.current_user.has_role?('admin'))
   @doctor = Doctor.find(doctor_id) unless doctor_id.blank?
   @date = (Date.parse(params[:date]) unless params[:date].blank?) || Date.today

   @appointments =  @doctor.appointments.on_date(@date) unless @doctor.blank?

   respond_to do |format|
      format.html # show.html.erb
      format.js  { render :update do |page|
                     if params[:filter] == '1'
                        page.replace_html 'appointment_list', :partial => 'appointment_list'
                     else
                        page.replace_html 'appointment_list', :partial => 'time_slots'
                     end  
                   end 
                 }
    end
  end
end
