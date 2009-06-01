class  Cms::NextAppointmentRemarksController < ApplicationController
  layout 'cms'

  def index
    @next_appointment_remarks = NextAppointmentRemark.all
  end

  def show
    @next_appointment_remark = NextAppointmentRemark.find(params[:id])
  end

  def new
  	@appointment = Appointment.find(params[:appointment_id])
    @next_appointment_remark = NextAppointmentRemark.new
    render :layout => false
  end

  def edit
    @next_appointment_remark = NextAppointmentRemark.find(params[:id])
    render :layout => false
  end

  def create
    @appointment = Appointment.find(params[:appointment_id])
    @next_appointment_remark  = NextAppointmentRemark.new(params[:next_appointment_remark])
    @next_appointment_remark.appointment = @appointment
    if @next_appointment_remark.save
      flash[:notice] = 'NextAppointmentRemark was successfully created.'
      redirect_to(new_cms_appointment_clinical_screen_path(@appointment))
    else
       render :action => "new"
    end
  end


  def update
  	@appointment = Appointment.find(params[:appointment_id])
    @next_appointment_remark = NextAppointmentRemark.find(params[:id])
    if @next_appointment_remark.update_attributes(params[:next_appointment_remark])
      flash[:notice] = 'NextAppointmentRemark was successfully updated.'
      redirect_to(new_cms_appointment_clinical_screen_path(@appointment))
    else
      render :action => "edit"
    end
  end

  def destroy
    @next_appointment_remark = NextAppointmentRemark.find(params[:id])
    @next_appointment_remark.destroy
    redirect_to(next_appointment_remarks_url)
  end

end
