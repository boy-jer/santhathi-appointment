class Pms::PatientDischargesController < ApplicationController
  layout proc{ |c| ['show','new', 'create'].include?(c.action_name)? 'pms_single_column' : 'pms'}
 
  def index
    @search = Appointment.new_search(params[:search])
    @search.conditions.state = 'recommend_for_discharge'
    @params = params[:search]
    @search.per_page ||= 25
    @search.order_as ||= "DESC"
    @search.order_by ||= "appointment_date"
    @appointments = @search.all 
  end
end
