class ClinicalCommentsController < ApplicationController
   layout 'cms'

  def index
    @clinical_comments = ClinicalComment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clinical_comments }
    end
  end


  def show
    @clinical_comment = ClinicalComment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @clinical_comment }
    end
  end


  def new
  	cm = ClinicalComment.find_by_appointment_id(params[:appointment_id])
    redirect_to edit_appointment_clinical_comment_path(:appointment_id => cm.appointment_id,:id=> cm.id) unless cm.blank?

  	@appointment = Appointment.find(params[:appointment_id])
    @clinical_comment = ClinicalComment.new
  end


  def edit
    @clinical_comment = ClinicalComment.find(params[:id])
  end


  def create
  	@appointment = Appointment.find(params[:appointment_id])
   # @clinical_comment = @appointment.clinical_comment.create(params[:clinical_comment])

   @clinical_comment = ClinicalComment.new(params[:clinical_comment])
   @clinical_comment.appointment = @appointment


    respond_to do |format|
      if @clinical_comment.save
        flash[:notice] = 'ClinicalComment was successfully created.'
        format.html { redirect_to(new_appointment_clinical_screen_path(@appointment)) }
        format.xml  { render :xml => @clinical_comment, :status => :created, :location => @clinical_comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @clinical_comment.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
  	@appointment = Appointment.find(params[:appointment_id])
    @clinical_comment = ClinicalComment.find(params[:id])

    respond_to do |format|
      if @clinical_comment.update_attributes(params[:clinical_comment])
        flash[:notice] = 'ClinicalComment was successfully updated.'
        format.html { redirect_to(new_appointment_clinical_screen_path(@appointment))}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @clinical_comment.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @clinical_comment = ClinicalComment.find(params[:id])
    @clinical_comment.destroy

    respond_to do |format|
      format.html { redirect_to(clinical_comments_url) }
      format.xml  { head :ok }
    end
  end


end
