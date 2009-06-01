class Cms::DoctorAppointmentsController < ApplicationController
  layout 'cms'

  def index
    @search = Appointment.new_search(params[:search])
    @search.per_page ||= 15
    @appointments = @search.all
    @doctor = Doctor.find(params[:search][:conditions][:doctor_id_like]) unless (params[:search].blank? || params[:search][:conditions][:doctor_id_like].blank?)
    @date = (Date.parse(params[:search][:conditions][:appointment_date_like]) unless (params[:search].blank? || params[:search][:conditions][:appointment_date_like].blank?)) || Date.today
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

  def show
    @doctor_appointment = DoctorAppointment.find(params[:id])
  end

  def new
    @doctor_appointment = DoctorAppointment.new
  end

  def edit
    @doctor_appointment = DoctorAppointment.find(params[:id])
  end

  def create
    @doctor_appointment = DoctorAppointment.new(params[:doctor_appointment])
    if @doctor_appointment.save
      flash[:notice] = 'DoctorAppointment was successfully created.'
      format.html { redirect_to(@doctor_appointment) }
    else
      render :action => "new"
    end
  end

  def update
    @doctor_appointment = DoctorAppointment.find(params[:id])
    if @doctor_appointment.update_attributes(params[:doctor_appointment])
      flash[:notice] = 'DoctorAppointment was successfully updated.'
      redirect_to(@doctor_appointment)
    else
       render :action => "edit"
    end
  end

  def destroy
    @doctor_appointment = DoctorAppointment.find(params[:id])
    @doctor_appointment.destroy
    redirect_to(cms_doctor_appointments_url)
  end

end
