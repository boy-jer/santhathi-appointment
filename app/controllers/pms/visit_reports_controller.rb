class Pms::VisitReportsController < ApplicationController
  layout 'pms_single_column'
  
  def index
    
  end

  def new
    @appointment = Appointment.find(params[:appointment_id])
  end

end
