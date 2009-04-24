class AppointmentsController < ApplicationController
layout 'pms'
require_role ["doctor", "admin", "reception"]#, :only => [:delete, :edit]
  # GET /appointments
  # GET /appointments.xml
  def index

  	@search = Appointment.new_search(params[:search])
    @search.per_page = 20

    @appointments,@appointment_count = @search.all,@search.count

    respond_to do |format|
              format.html
              format.js {
                      render :update do |page|
                        page.replace_html 'appointment-list', :partial => 'appointments_list'
                      end
                      }
              end

  end

  # GET /appointments/1
  # GET /appointments/1.xml
  def show
    @appointment = Appointment.find(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @appointment }
      format.js { render :layout => false }
    end
  end

  # GET /appointments/new
  # GET /appointments/new.xml
  def new
  	@appointment = Appointment.new
    @patient = params[:patient_id].blank? ? Patient.new : Patient.find(params[:patient_id])

    #@patient = Patient.new(:reg_no => generate_identifier)
    respond_to do|format|
      format.html # new.html.erb
      format.xml  { render :xml => @appointment }
    end
  end

  # GET /appointments/1/edit
  def edit
    @appointment = Appointment.find(params[:id])
    @patient = @appointment.patient
    @hour = Time.parse(@appointment.appointment_time.to_s).strftime('%H').to_i
    @minute = Time.parse(@appointment.appointment_time.to_s).strftime('%M').to_i
  end

  # POST /appointments
  # POST /appointments.xml
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

  # PUT /appointments/1
  # PUT /appointments/1.xml
  def update
    @appointment = Appointment.find(params[:id])
    @appointment.update_attribute('updated_by_id',@current_user.id)
    respond_to do |format|

      if @appointment.update_attributes(params[:appointment])

        flash[:notice] = 'Appointment was successfully updated.'
        format.html { redirect_to(appointments_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @appointment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.xml
  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.cancel!

    respond_to do |format|
      format.html { redirect_to(appointments_url) }
      format.xml  { head :ok }
    end
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

private

end
