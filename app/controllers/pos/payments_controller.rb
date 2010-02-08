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
    @appointment = Appointment.find(params[:appointment_id])
    @payment = Payment.new
    @inventory_items = user_default_branch.inventory_items.non_consumables.all
    @services = Service.all
    @inventory_groups = user_default_branch.inventory_groups.all
    @departments = Department.all
    @prescribed_services = @appointment.prescription.prescribed_tests.map{|pt| pt.service}
    @prescribed_medicines = @appointment.pharmacy_prescriptions
  end

  def create
    @appointment_id = params[:appointment_id]
    @payment = Payment.new(params[:payment])
    @payment.appointment_id = @appointment_id
    if @payment.save
      flash[:notice] = 'Payment has been done succussfully'
      redirect_to pos_payment_path(@payment)
    else
      @appointment = Appointment.find(params[:appointment_id])
      @inventory_items = user_default_branch.inventory_items.non_consumables.all
      @services = Service.all
      @inventory_groups = user_default_branch.inventory_groups.all
      @departments = Department.all
      @prescribed_services = @appointment.prescription.prescribed_tests.map{|pt| pt.service}
      @prescribed_medicines = @appointment.pharmacy_prescriptions
      render :action => 'new' 
    end
  end

  def show
    @payment = Payment.find(params[:id])    
  end

  def recieve_payment
    @payment = Payment.find(params[:id])  
    @payment.recieve_payment!
    redirect_to pos_payment_path(@payment) 
  end

  def cancel_payment
    @payment = Payment.find(params[:id])
    @payment.cancel_payment!  
    redirect_to pos_payment_path(@payment)
  end
end
