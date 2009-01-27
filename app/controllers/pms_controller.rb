class PmsController < ApplicationController
   layout 'admin'
  # GET /pms
  # GET /pms.xml
  def index
    @pms = Pms.find(:all)
    redirect_to appointments_url
  end

  # GET /pms/1
  # GET /pms/1.xml
  def show
    @pms = Pms.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pms }
    end
  end

  # GET /pms/new
  # GET /pms/new.xml
  def new
    @pms = Pms.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pms }
    end
  end

  # GET /pms/1/edit
  def edit
    @pms = Pms.find(params[:id])
  end

  # POST /pms
  # POST /pms.xml
  def create
    @pms = Pms.new(params[:pms])

    respond_to do |format|
      if @pms.save
        flash[:notice] = 'Pms was successfully created.'
        format.html { redirect_to(@pms) }
        format.xml  { render :xml => @pms, :status => :created, :location => @pms }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pms.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pms/1
  # PUT /pms/1.xml
  def update
    @pms = Pms.find(params[:id])

    respond_to do |format|
      if @pms.update_attributes(params[:pms])
        flash[:notice] = 'Pms was successfully updated.'
        format.html { redirect_to(@pms) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pms.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pms/1
  # DELETE /pms/1.xml
  def destroy
    @pms = Pms.find(params[:id])
    @pms.destroy

    respond_to do |format|
      format.html { redirect_to(pms_url) }
      format.xml  { head :ok }
    end
  end

  
end
