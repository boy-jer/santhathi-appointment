class PmsReportsController < ApplicationController
   layout 'pms'



  def reports
  	@type = params[:type]
  end

  def date_wise_reports
  	unless params[:from_date].blank? and params[:to_date].blank?
  	  @from_date = params[:from_date].to_date
  	  @to_date = params[:to_date].to_date
      @reports =  Appointment.count(:conditions => {:appointment_date=>@from_date..@to_date},:group=>"appointment_date") if params[:option]=="day"
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reports }
    end
   end

  def department_wise_report
  	 unless params[:from_date].blank? and params[:to_date].blank?
  	 	 @from_date = params[:from_date].to_date
  	     @to_date = params[:to_date].to_date
  	     if params[:department_id] == "All"
  	     	@department_name = "All Departments"
  	     	department_ids = Department.find(:all).map{ |department| department.id }
  	     	@reports = Appointment.count(:group =>"appointment_date",
  	     	         :conditions =>["appointment_date IN (?) and department_id IN (?)",@from_date..@to_date,department_ids])
 	     else
           department = Department.find(params[:department_id])
           @department_name = department.dept_name
           @reports = department.appointments.count(:conditions => {:appointment_date=>@from_date..@to_date},:group =>"appointment_date")
         end
 	 end
   end


   def doctor_wise_report
      unless params[:from_date].blank? and params[:to_date].blank?
		@from_date = params[:from_date].to_date
  	    @to_date = params[:to_date].to_date
=begin
  	    if params[:department_id] == "All" and params[:doctor_id] =="All"


 	    elsif params[:department_id] == "All" and params[:doctor_id] !="All"
 	      @reports = Appointment.count(:group =>"appointment_date",:conditions =>["appointment_date IN (?) and doctor_id = ?",@from_date..@to_date,params[:doctor_id]])

    	elsif params[:department_id] != "All" and params[:doctor_id] =="All"
	      doctors_ids = Department.find(params[:department_id]).doctors.map{|doctor| doctor.id }.join(',')
	      @reports = Appointment.count(:group =>"appointment_date",:conditions =>["appointment_date IN (?) and doctor_id IN (#{doctors_ids})",@from_date..@to_date])
        else
          @reports = Appointment.count(:group =>"appointment_date",:conditions =>["appointment_date IN (?) and doctor_id = ?",@from_date..@to_date,params[:doctor_id]])

        end
=end

       if params[:doctor_id] == "All"
       	 @doctor_ids = Doctor.find(:all).map{|doc| doc.id}

       else
      	  @reports = Appointment.count(:group =>"appointment_date",:conditions =>["appointment_date IN (?) and doctor_id = ?",@from_date..@to_date,params[:doctor_id]])
       	  @doctor_ids = params[:doctor_id]
       end

      end
   end


   def appointment_type_report
   	  unless params[:from_date].blank? and params[:to_date].blank?
   	  	@from_date = params[:from_date].to_date
  	    @to_date = params[:to_date].to_date
		@mode_ids = Mode.find(:all,:order=>'name').map{ |mode| mode.id}
		@total_others = 0
		@total_telephonic = 0
		@total_walkins = 0
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
