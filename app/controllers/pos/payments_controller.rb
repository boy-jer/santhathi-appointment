class Pos::PaymentsController < ApplicationController
  layout 'pms'

  def index
    @search = Appointment.new_search(params[:search])
    @search.conditions.state = 'recommend_for_discharge'
    @params = params[:search]
    @search.per_page ||= 25
    @search.order_as ||= "DESC"
    @search.order_by ||= "appointment_date"
    @appointments = @search.all 
  end

  def new

  end
end
