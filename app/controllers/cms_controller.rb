class CmsController < ApplicationController
  layout 'admin'
  # GET /cms
  # GET /cms.xml
  def index
    @cms = Cms.find(:all)
    
    redirect_to doctor_appointments_url
  end

  # GET /cms/1
  # GET /cms/1.xml
  def show
    @cms = Cms.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cms }
    end
  end

  # GET /cms/new
  # GET /cms/new.xml
  def new
    @cms = Cms.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cms }
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

  # PUT /cms/1
  # PUT /cms/1.xml
  def update
    @cms = Cms.find(params[:id])

    respond_to do |format|
      if @cms.update_attributes(params[:cms])
        flash[:notice] = 'Cms was successfully updated.'
        format.html { redirect_to(@cms) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cms.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cms/1
  # DELETE /cms/1.xml
  def destroy
    @cms = Cms.find(params[:id])
    @cms.destroy

    respond_to do |format|
      format.html { redirect_to(cms_url) }
      format.xml  { head :ok }
    end
  end
end
