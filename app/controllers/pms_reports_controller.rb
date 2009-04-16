class PmsReportsController < ApplicationController
   layout 'pms'



  def reports
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
  	     if params[:department] == "All"
 	     else
           department = Department.find(params[:department])
           @reports = department.appointments.count(:group =>"appointment_date")
         end


 	 end

  end






end
