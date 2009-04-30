class AppointmentsController < ApplicationController
layout 'pms'
require 'fastercsv'
require_role ["doctor", "admin", "reception"]#, :only => [:delete, :edit]

  def index
    @search = Appointment.new_search(params[:search])
    @params = params[:search]
    @search.per_page ||= 5
    @appointments = @search.all
    respond_to do |format|
                  format.html
                  format.js { render :update do |page|
                               page.replace_html 'appointment-list', :partial => 'appointments_list'
                             end
                             }

                  format.csv {
                              csv_file = FasterCSV.generate do |csv|
                                 #Headers
                                 csv << ['Appointment No', 'Appointment Date', 'Appointment Time', 'Doctor Name', 'Patient Name', 'Reason', 'Status', 'Reg No']

                                 #Data
                                 @appointments.each do |app|
                                   csv << [app.id, app.appointment_date, app.appointment_time.strftime('%H:%M'), app.doctor.name, app.patient.patient_name, app.reason.name, app.state, app.patient.reg_no ]
                                 end
                               end
                               #sending the file to the browser
                               send_data(csv_file, :filename => 'credit_desk_users_list.csv', :type => 'text/csv', :disposition => 'attachment')
                             }
                   format.pdf {
                               options = {:left_margin   => 20,
                                          :right_margin  => 20,
                                          :top_margin    => 20,
                                          :bottom_margin => 20
    				         }
                               prawnto :inline=>true, :prawn=> options, :filename => "appointments.pdf"
                               render :layout => false
                              }
                end
  end

  def show
    @appointment = Appointment.find(params[:id])

    respond_to do |format|
      format.html
      format.js { render :layout => false }
    end
  end

  def new
  	@appointment = Appointment.new
    @patient = params[:patient_id].blank? ? Patient.new : Patient.find(params[:patient_id])
  end

  def edit
    @appointment = Appointment.find(params[:id])
    @patient = @appointment.patient
    @hour = Time.parse(@appointment.appointment_time.to_s).strftime('%H').to_i
    @minute = Time.parse(@appointment.appointment_time.to_s).strftime('%M').to_i
  end

 def create
    date = session[:date].blank? ? Date.today : session[:date]
    @appointment = Appointment.new(params[:appointment].merge({:appointment_date => date}))
    @appointment.department_id = params[:departament][:id]
    if params[:appointment][:visit_type] == 'yes'
      @patient = Patient.new(params[:patient])
      @patient.reg_date = Date.today
    else
      @patient = Patient.find(params[:patient_id])
    end

    if [@appointment.valid?, @patient.valid?].all?
      if @appointment.save && @patient.save
        @appointment.patient = @patient
        @appointment.created_by_id = @current_user.id
        @appointment.updated_by_id = @current_user.id
        @appointment.save
        flash[:notice] = 'Appointment was successfully created.'
        redirect_to appointments_path
      else
        render :action => "new"
      end
    else
      render :action => "new"
    end
  end


  def update
    @appointment = Appointment.find(params[:id])
    @appointment.update_attribute('updated_by_id',@current_user.id)

    if @appointment.update_attributes(params[:appointment])
      flash[:notice] = 'Appointment was successfully updated.'
      redirect_to(appointments_path)
    else
      render :action => "edit"
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.cancel!
    redirect_to(appointments_url)
  end

  def update_doctors
    # updates doctors list based on department selected
    department = Department.find(params[:department])
    doctors  = department.doctors

    render :update do |page|
      page.replace_html 'doctors', :partial => 'doctors_list', :object => doctors
    end
  end

  def patient_search
    @patients = Patient.name_filter(params[:name]) unless params[:name].blank?
    render :update do |page|
      page.replace_html 'patient_search_results', :partial => 'patient_search_results', :object => @patients
    end
  end

  def confirm
    @appointment = Appointment.find(params[:id])
    if @appointment.new_appointment?
       @appointment.mark_visited!
       page = params[:page].blank? ? 1: params[:page]
       redirect_to(appointments_path(:page => page))
    end
  end

  def update_doctors_list
    dept_id = params[:department_id]
    if dept_id.blank?
      @doctors = Doctor.find(:all).collect{|x| [x.name, x.id]}
    else
      @doctors = Department.find(dept_id).doctors.collect{|x| [x.name, x.id]}
    end

    render :update do |page|
      page.replace_html 'doctors', :partial => 'doctors_list', :object => @doctors
    end

  end

end
