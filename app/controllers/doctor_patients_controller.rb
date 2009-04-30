class DoctorPatientsController < ApplicationController
   layout 'cms'
  # GET /doctor_appointments
  # GET /doctor_appointments.xml
  def index
    @search = Appointment.new_search(params[:search])
    @search.per_page ||= 5
    @appointments = @search.all

    respond_to do |format|
              format.html
              format.js {
                      render :update do |page|
                        page.replace_html 'appointment-list', :partial => 'patient_list'
                      end
                      }
              end

  end

  def discharge
    date = (Date.parse(params[:date]) unless params[:date].blank?) || Date.today
    appointments = Appointment.on_date(date).status('visited')
    appointments.map {|appointment| appointment.discharge!}
    redirect_to doctor_patients_path
  end

  def update
    unless params[:appointment].blank?
      params[:appointment].map{ |id| appointment = Appointment.find(id)
                                appointment.recommend_for_discharge! unless (appointment.blank? && appointment.visited?)}
      redirect_to doctor_patients_path
    else
      flash[:notice]=" Please select at least one appointment."
      redirect_to doctor_patients_path
    end
  end

  def clinical_screen
    unless params[:id].blank?
       @appointment = Appointment.find(params[:id])
       @patient = @appointment.patient
       @doctor = @appointment.doctor
       @lab_services = LabTest.find_all_by_parent_id(nil)
       @department = Department.find_by_dept_name("laboratory")
       @prescribed_tests = @appointment.prescription.prescribed_tests unless @appointment.prescription.blank?
     else
      flash[:notice]=" Please select at least one appointment."
      redirect_to doctor_patients_path
    end
  end

end
