class Cms::PatientsController < ApplicationController
  layout 'cms_single_column'

  def index
    @search = Appointment.new_search(params[:search])
    @search.conditions.state = ['visited', 'prescribed', 'recommend_for_discharge']
    @search.conditions.doctor_id = current_user.id unless admin?
    @search.order_as ||= "DESC"
    @search.order_by ||= "created_at"
    @search.per_page ||= 50
    @appointments = @search.all
    respond_to do |format|
      format.html
      format.js  {
                    render :update do |page|
                      page.replace_html 'appointment-list', :partial => '/cms/patients/patient_list'
                    end
                  }
    end
  end

  def discharge
    date = (Date.parse(params[:date]) unless params[:date].blank?)
    unless date.blank?
      appointments = Appointment.on_date(date).visited_and_discharge_recomonded_and_prescribed
      appointments.map {|appointment| appointment.recommend_for_discharge! unless appointment.recommend_for_discharge?}
    else
      appointment = Appointment.find(params[:a]) unless params[:a].blank?
      appointment.recommend_for_discharge! unless (appointment.blank? or appointment.recommend_for_discharge?)
    end
    redirect_to cms_doctor_patients_path(current_user.id)
  end

  def update
    unless params[:appointment].blank?
      params[:appointment].map{ |id| appointment = Appointment.find(id)
                                appointment.recommend_for_discharge! unless (appointment.blank? && appointment.visited?)}
      redirect_to cms_doctor_patients_path(current_user.id)
    else
      flash[:notice]=" Please select at least one appointment."
      redirect_to cms_doctor_patients_path(current_user.id)
    end
  end

  def clinical_screen
    unless params[:id].blank?
      @appointment = Appointment.find(params[:id])
      @patient = @appointment.patient
      @doctor = @appointment.doctor
      @lab_services = Service.lab_services.top_level
      @department = Department.find_by_dept_name("laboratory")
      @prescribed_tests = @appointment.prescription.prescribed_tests unless @appointment.prescription.blank?
    else
      flash[:notice]=" Please select at least one appointment."
      redirect_to cms_doctor_patients_path(current_user.id)
    end
  end

end

