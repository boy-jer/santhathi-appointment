class PrescriptionsController < ApplicationController
  layout 'cms'

  def new
    @prescription = Prescription.new
    @department = Department.find(params[:department])
    @appointment = Appointment.find(params[:appointment])
    @child_list = @department.services.find_all_by_parent_id(nil)

    respond_to do |format|
      format.html
      format.js { render :layout => false }
    end 
  end

  # GET /cms/1/edit
  def edit
    @cms = Cms.find(params[:id])
  end

  # POST /cms
  # POST /cms.xml
  def create
    @cms = Cms.new(params[:cms])

    respond_to do |format|
      if @cms.save
        flash[:notice] = 'Cms was successfully created.'
        format.html { redirect_to(@cms) }
        format.xml  { render :xml => @cms, :status => :created, :location => @cms }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cms.errors, :status => :unprocessable_entity }
      end
    end
  end
end
