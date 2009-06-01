class Cms::ReferDoctorsController < ApplicationController
	layout 'cms'
 before_filter :find_appointment

  def index
    @refer_doctors = @appointment.refer_doctors

    respond_to do |format|
      format.html
    end
  end


  def show
    @refer_doctor = ReferDoctor.find(params[:id])

    respond_to do |format|
      format.html
    end
  end


  def new
    @refer_doctor = ReferDoctor.new

    respond_to do |format|
      format.html
    end
  end


  def edit
    @refer_doctor = ReferDoctor.find(params[:id])
  end


  def create
    @refer_doctor = ReferDoctor.new(params[:refer_doctor])
    @refer_doctor.doctor_id = params[:appointment][:doctor_id]
    respond_to do |format|
      if @refer_doctor.save
        flash[:notice] = 'ReferDoctor was successfully created.'
        format.html { redirect_to(cms_appointment_refer_doctors_path(:appointment_id => @appointment )) }
     else
        format.html { render :action => "new" }
      end
    end
  end


  def update
    @refer_doctor = ReferDoctor.find(params[:id])
    @refer_doctor.doctor_id = params[:appointment][:doctor_id]
    respond_to do |format|
      if @refer_doctor.update_attributes(params[:refer_doctor])
        flash[:notice] = 'ReferDoctor was successfully updated.'
        format.html { redirect_to(cms_appointment_refer_doctors_path(:appointment_id => @appointment)) }

      else
        format.html { render :action => "edit" }

      end
    end
  end


  def destroy
    @refer_doctor = ReferDoctor.find(params[:id])
    @refer_doctor.destroy

    respond_to do |format|
      format.html { redirect_to(cms_appointment_refer_doctors_path(:appointment_id => @appointment) ) }
    end
  end

  private

  def find_appointment
  	@appointment = Appointment.find(params[:appointment_id])
 	end
end
