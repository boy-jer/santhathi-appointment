class  Cms::DischargeSummariesController < ApplicationController
  layout 'cms'

  def index
    @discharge_summaries = DischargeSummary.all
  end

  def show
    @discharge_summary = @appointment.discharge_summary.find(params[:id])
  end

  def new
  	@appointment = Appointment.find(params[:appointment_id])
    @discharge_summary = DischargeSummary.new
  end

  def edit
    @discharge_summary = DischargeSummary.find(params[:id])
  end

  def create
  	@appointment = Appointment.find(params[:appointment_id])
    @discharge_summary  = DischargeSummary.new(params[:discharge_summary])
    @discharge_summary.appointment = @appointment
    if @discharge_summary.save
      flash[:notice] = 'DischargeSummary was successfully created.'
      redirect_to(new_cms_appointment_clinical_screen_path(@appointment))
    else
      render :action => "new"
    end
  end

  def update
  	@appointment = Appointment.find(params[:appointment_id])
    @discharge_summary = DischargeSummary.find(params[:id])
    if @discharge_summary.update_attributes(params[:discharge_summary])
      flash[:notice] = 'DischargeSummary was successfully updated.'
      redirect_to(new_cms_appointment_clinical_screen_path(@appointment))
    else
      render :action => "edit"
    end
  end

  def destroy
    @discharge_summary = DischargeSummary.find(params[:id])
    @discharge_summary.destroy
    redirect_to(discharge_summaries_url)
  end

end
