class Pms::VisitReportsController < ApplicationController
  layout 'pms_single_column'
  require_role ["doctor", "admin", "reception"]

  def index
    
  end

  def new
    @appointment = Appointment.find(params[:appointment_id])
  end

end
