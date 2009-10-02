class Pms::AppointmentsController < ApplicationController
  layout proc{ |c| ['show','new', 'create'].include?(c.action_name)? 'pms_single_column' : 'pms'}
  require 'fastercsv'
  require_role ["doctor", "admin", "reception"]#, :only => [:delete, :edit]

  def index
    unless params.has_key?(:date) # IF it is a ajax request to update doctor's schedule don't do search TODO: move it to separate action
      @search = Appointment.new_search(params[:search])
      @params = params[:search]
      @search.per_page ||= 15
      @search.order_as ||= "DESC"
      @search.order_by ||= "appointment_date"

      @appointments = @search.all 
    end

    respond_to do |format|
      format.html
      format.js { render :update do |page|
                    unless params[:tab]
                      page.replace_html 'appointment-list', :partial => 'appointments_list'
                    else  
                      page.replace_html 'appointment-list', :partial => 'appointments_list_table'
                    end
                  end
                }

     format.csv {
                  csv_file = FasterCSV.generate do |csv|
                    #Headers
                    csv << ['Appointment No', 'Appointment Date', 'Appointment Time', 'Doctor Name', 'Patient Name', 'Reason', 'Status', 'Reg No']
                    #Data
                    @appointments.each do |app|
                      csv << [app.id, app.appointment_date, app.appointment_time.strftime('%H:%M'), app.doctor.doctor_profile.name, app.patient.patient_name, app.reason.name, app.state, app.patient.reg_no ]
                    end
                 end
                 #sending the file to the browser
                 send_data(csv_file, :filename => 'appointments_list.csv', :type => 'text/csv', :disposition => 'attachment')
                }
     format.pdf {
                  options = { :left_margin   => 20,
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
     render :layout => false
 end

  def new
    @appointment = Appointment.new
    @patient = params[:patient_id].blank? ? Patient.new : Patient.find(params[:patient_id])
    respond_to do |format|
      format.html
      format.js { render :update do |page|
                    @doctor = Doctor.find(params[:doctor]) unless params[:doctor].blank?
                    @date = Date.parse(params[:date])
                    @date ||= Date.today
                    unless @doctor.blank?
                      @appointments = {}
                      #collect all appointments for this doctor and put it in a hash. time slot being key
                      @doctor.appointments.on_date(@date).active.collect {|a| @appointments[a.appointment_time.strftime('%H:%M').to_s]= a}
                      page.replace_html 'schedule', :partial => 'appointments_detail', :locals => {:doctor => @doctor, :date =>@date, :appointments => @appointments}
                      page.visual_effect(:highlight, "main_schedules", :duration => 2)
                    end
                  end
                }
    end
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
        flash[:notice] = 'Appointment is successfully created.'
        redirect_to pms_appointments_url
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
      flash[:notice] = 'Appointment is successfully updated.'
      redirect_to(pms_appointments_url)
    else
      render :action => "edit"
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.cancel!
    redirect_to(pms_appointments_url)
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
    @patients = Patient.all(:conditions =>{:patient_name_like => params[:name] ,:contact_no_like => params[:number] ,:reg_no_like => params[:reg_num],:spouse_is_null => true})
    render :update do |page|
      page.replace_html 'patient_search_results', :partial => 'patient_search_results', :object => @patients
    end
  end


  def confirm
    @appointment = Appointment.find(params[:id])
    if @appointment.patient.reg_no.blank? 
      flash[:notice] = "Patient is Not Registered, Please Register"
    else  
       if @appointment.new_appointment?
        @appointment.mark_visited!
        page = params[:page].blank? ? 1 : params[:page]
       end
    end
    redirect_to(pms_appointments_url(:page => page)) 
  end



  def update_doctors_list
    dept_id = params[:department_id]
    if dept_id.blank?
      @doctors = Doctor.find(:all).collect{|x| [x.doctor_profile.name, x.id]}
    else
     # @doctors = Department.find(dept_id).doctors.collect{|x| [x.name, x.id]}
     @doctors = DoctorProfile.find(:all,:conditions =>["department_id = ? ", dept_id]).map {|ob| [ob.name ,ob.doctor.id]}
    end

    render :update do |page|
      page.replace_html 'doctors', :partial => 'doctors_list', :object => @doctors
    end

  end

end
