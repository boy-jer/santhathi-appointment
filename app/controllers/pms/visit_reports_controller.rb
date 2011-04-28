class Pms::VisitReportsController < ApplicationController
  layout 'pms_single_column'

  def index
     @search = Appointment.new_search(params[:search])
     @search.per_page ||= 25
     @search.order_as ||= "DESC"
     @search.order_by ||= [:appointment_date,:appointment_time]
      #@search.order_as ||= "DESC"
      #@search.order_by ||= "appointment_time"
     @appointments = @search.all
     respond_to do |format|
      format.html
      format.js { render :update do |page|

                      page.replace_html 'appointment-list', :partial => 'appointments_list_table'

                  end
                }
              end
  end

  def new
   @appointment = Appointment.find(params[:appointment_id])
   @prescribed_tests = PrescribedTest.find(:all,:include =>[:prescription,:service],:conditions =>['prescriptions.appointment_id = ? and services.department_id =?' ,@appointment.id,Department.find(:first, :select => :id, :conditions => "dept_name like '%Lab%'").id])
   @next_appointment = Appointment.find(:last,:conditions => ['patient_id = ? and state =? and doctor_id = ?',@appointment.patient_id,"new_appointment",@appointment.doctor_id])
   @pharmacy_prescriptions = @appointment.pharmacy_prescriptions

  end

   def search
   end


end

