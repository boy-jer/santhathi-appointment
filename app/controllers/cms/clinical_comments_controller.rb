class Cms::ClinicalCommentsController < ApplicationController
  layout 'cms'

  def index
    @clinical_comments = ClinicalComment.all
  end

  def show
    @clinical_comment = ClinicalComment.find(params[:id])
  end

  def new
   	@appointment = Appointment.find(params[:appointment_id])
    @clinical_comment = ClinicalComment.new
  end

  def edit
    @clinical_comment = ClinicalComment.find(params[:id])
  end

  def create
    @appointment = Appointment.find(params[:appointment_id])
    @clinical_comment = ClinicalComment.new(params[:clinical_comment])
    @clinical_comment.appointment = @appointment
    if @clinical_comment.save
      flash[:notice] = 'ClinicalComment was successfully created.'
      redirect_to(new_cms_appointment_clinical_screen_path(@appointment))
    else
      render :action => "new"
    end
  end

  def update
    @appointment = Appointment.find(params[:appointment_id])
    @clinical_comment = ClinicalComment.find(params[:id])
    if @clinical_comment.update_attributes(params[:clinical_comment])
      flash[:notice] = 'ClinicalComment was successfully updated.'
      redirect_to(new_cms_appointment_clinical_screen_path(@appointment))
    else
      render :action => "edit"
    end
  end

  def destroy
    @clinical_comment = ClinicalComment.find(params[:id])
    @clinical_comment.destroy
    redirect_to(clinical_comments_url)
  end
end
