class Pos::PaymentsController < ApplicationController
  layout 'pms_single_column'

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

    unless @appointment.prescription.blank?
      @prescribed_services = @appointment.prescription.prescribed_tests.map{|pt| pt.service}
    else
      @prescribed_services = []
    end
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
      unless @appointment.prescription.blank?
        @prescribed_services = @appointment.prescription.prescribed_tests.map{|pt| pt.service}
      else
        @prescribed_services = []
      end
      @prescribed_medicines = @appointment.pharmacy_prescriptions
      render :action => 'new' 
    end
  end

  def show
    @payment = Payment.find(params[:id])    
    @accounts = user_default_branch.accounts
    @cash_account = @accounts.find_by_name(CASH_AC[:name])
  end

  def recieve_payment
    @payment = Payment.find(params[:id])
    debit_account = user_default_branch.accounts.find(params[:debit_account_id])
    @payment.update_attribute(:debit_account_id, debit_account.id)
    @payment.recieve_payment!
    redirect_to pos_payment_path(@payment) 
  end

  def cancel_payment
    @payment = Payment.find(params[:id])
    @payment.cancel_payment!  
    redirect_to pos_payment_path(@payment)
  end
end
