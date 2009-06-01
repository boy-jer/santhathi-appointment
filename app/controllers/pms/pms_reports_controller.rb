class Pms::PmsReportsController < ApplicationController
  layout 'pms'

  def index
  	#@type = params[:type].nil? "Appointment" : params[:type]
  	 if params[:type].nil?
  	 	@type = "Appointment"
 	 else
 	 	@type = params[:type]
	 end
  end

  def date_wise_reports
  	if !params[:from_date].blank? and  !params[:to_date].blank? and  params[:option] == "day"
  	  @from_date = params[:from_date].to_date
  	  @to_date = params[:to_date].to_date
  	  @reports =  Appointment.date_wise_report(@from_date,@to_date,params[:option])
  	  @count =  Appointment.count_appointment(@from_date,@to_date)
    elsif !params[:from_date].blank? and  !params[:to_date].blank? and  params[:option] == "month"
    	params[:option] = "month"
    	 @from_date = params[:from_date].to_date
  	   @to_date = params[:to_date].to_date
    	app = Appointment.find(:all, :conditions => ["appointment_date >= ? and appointment_date <= ?",@from_date,@to_date])
    	@reports = {}
      app_months = app.group_by { |t| t.appointment_date.beginning_of_month }
      app_months.each_key { |key| @reports[key] = app_months[key].size  }
  	else
    end
  end


  def visit_type_report
   unless params[:from_date].blank? and params[:to_date].blank?
     @from_date = params[:from_date].to_date
     @to_date = params[:to_date].to_date
     @first_visit_reports = Appointment.visit_type(@from_date,@to_date,"yes")
     @follow_up_reports =  Appointment.visit_type(@from_date,@to_date,"no")
     @count =  Appointment.count_appointment(@from_date,@to_date)
 	 end
  end

  def department_wise_report
  	unless params[:from_date].blank? and params[:to_date].blank?
  	  @from_date = params[:from_date].to_date
  	  @to_date = params[:to_date].to_date
  	  @reports = Appointment.departament_report(@from_date,@to_date,params[:department_id])
  	  @department_name = params[:department_id] == "All"? "All Departments" : Department.find(params[:department_id]).dept_name
  	  @count = Appointment.count_department_appointment(@from_date,@to_date,params[:department_id])
 	  end
  end

  def doctor_wise_report
    unless params[:from_date].blank? and params[:to_date].blank?
		  @from_date = params[:from_date].to_date
  	  @to_date = params[:to_date].to_date
  	  @reports = {}
      @counts = {}
      @reports = Appointment.doctor_report(@from_date,@to_date,params[:doctor_id])
      @counts = Appointment.count_doctor_appointment(@from_date,@to_date,params[:doctor_id])
      @count  = Appointment.count_doctor_appointments(@from_date,@to_date,params[:doctor_id])
      if params[:doctor_id] == "All"
        @doctors_list = Doctor.doctors_list
      else
        doc = Doctor.find(params[:doctor_id])
        @doctors_list = [[doc.name, doc.id]]
      end
    end
  end

  def appointment_type_report
    unless params[:from_date].blank? and params[:to_date].blank?
    	@from_date = params[:from_date].to_date
  	  @to_date = params[:to_date].to_date
		  @reports = {}
      @counts = {}
      @modes = Mode.modes_list
      @reports = Appointment.mode_report(@from_date,@to_date)
      @count  = Appointment.count_doctor_appointments(@from_date,@to_date,"All")
	  end
  end

  def update_doctors
    @doctors = Department.find(params[:department_id]).doctors.collect{|x| [x.name, x.id]}
    render :update do |page|
      page.replace_html 'doctor_list', :partial => 'doctors_list', :object => @doctors
    end
  end

end


=begin
   @search  = Appointment.new_search()
   @search.group = [:appointment_date]
    @search.select = ['count(*) AS count_all, appointment_date AS appointment_date']
=end
