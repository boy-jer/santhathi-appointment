class Cms::ClinicalCommentsController < ApplicationController
  layout 'cms'
  require_role ["doctor", "admin"]

  def index
    @appointment = Appointment.find(params[:appointment_id])
    @clinical_comments = ClinicalComment.all
  end

  def show
    @clinical_comment = ClinicalComment.find(params[:id])
  end

  def new
    @appointment = Appointment.find(params[:appointment_id])
    @clinical_comments = ClinicalComment.find(:all, :conditions => "appointment_id in (#{@appointment.patient.appointments.collect{|p| p.id}})")

    @clinical_comment = ClinicalComment.new
    respond_to do |format|
      format.html
      format.js  {
                    render :update do |page|
                      page.replace_html 'clinical-screen', :partial => 'new'
                    end
                  }
    end
  end

  def edit
    @appointment = Appointment.find(params[:appointment_id])
    patient = @appointment.patient
    @clinical_comments = ClinicalComment.find(:all, :conditions => "appointment_id in (#{patient.appointments.collect{|p| p.id}})")

    @clinical_comment = ClinicalComment.find(params[:id])
     respond_to do |format|
      format.html
      format.js  {
                    render :update do |page|
                      page.replace_html 'clinical-screen', :partial => 'edit'
                    end
                  }
    end
  end

  def create
    @appointment = Appointment.find(params[:appointment_id])
    @clinical_comment = ClinicalComment.new(params[:clinical_comment])
    @clinical_comment.appointment = @appointment
    if @clinical_comment.save
      flash[:notice] = 'Clinical comment is successfully created.'
      redirect_to(new_cms_appointment_clinical_screen_path(@appointment))
    end
  end

  def update
    @appointment = Appointment.find(params[:appointment_id])
    @clinical_comment = ClinicalComment.find(params[:id])
    if @clinical_comment.update_attributes(params[:clinical_comment])
      flash[:notice] = 'Clinical comment is successfully updated.'
      redirect_to(new_cms_appointment_clinical_screen_path(@appointment))
    end
  end

  def destroy
    @clinical_comment = ClinicalComment.find(params[:id])
    @clinical_comment.destroy
    redirect_to(clinical_comments_url)
  end
end
