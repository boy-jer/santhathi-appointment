class RegistrationSummariesController < ApplicationController
    layout 'cms'
  def index
    @registration_summaries = RegistrationSummary.paginate :page => params[:page],:per_page => 10

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @registration_summaries }
    end
  end

  # GET /registration_summaries/1
  # GET /registration_summaries/1.xml
  def show
    @registration_summary = RegistrationSummary.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @registration_summary }
        format.js { render :layout => false }
    end
  end

  # GET /registration_summaries/new
  # GET /registration_summaries/new.xml
  def new
    @registration_summary = RegistrationSummary.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @registration_summary }
    end
  end

  # GET /registration_summaries/1/edit
  def edit
    @registration_summary = RegistrationSummary.find(params[:id])
  end

  # POST /registration_summaries
  # POST /registration_summaries.xml
  def create
    @registration_summary = RegistrationSummary.new(params[:registration_summary])

    respond_to do |format|
      if @registration_summary.save
        flash[:notice] = 'RegistrationSummary was successfully created.'
        format.html { redirect_to(@registration_summary) }
        format.xml  { render :xml => @registration_summary, :status => :created, :location => @registration_summary }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @registration_summary.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /registration_summaries/1
  # PUT /registration_summaries/1.xml
  def update
    @registration_summary = RegistrationSummary.find(params[:id])

    respond_to do |format|
      if @registration_summary.update_attributes(params[:registration_summary])
        flash[:notice] = 'RegistrationSummary was successfully updated.'
        format.html { redirect_to(@registration_summary) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @registration_summary.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /registration_summaries/1
  # DELETE /registration_summaries/1.xml
  def destroy
    @registration_summary = RegistrationSummary.find(params[:id])
    @registration_summary.destroy

    respond_to do |format|
      format.html { redirect_to(registration_summaries_url) }
      format.xml  { head :ok }
    end
  end
end
