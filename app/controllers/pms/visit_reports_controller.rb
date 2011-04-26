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
   @tests = ['PROLACTIN','IUI','BLOOD GROUP','RBS','FSH','HB','VDRL','TSH','TESTOSTERONE','LH','HIV','HBSAG','ULTRASOUND SCAN']
   service_ids = []
   @tests.each  do |test|
  service_ids << Service.find_by_name(test).id unless Service.find_by_name(test).nil?
end
    @prescribed_tests = PrescribedTest.find(:all,:include =>[:prescription],:conditions =>['prescriptions.appointment_id = ? and service_id in (?)' ,@appointment.id,service_ids])
  end

   def search
   end


end

