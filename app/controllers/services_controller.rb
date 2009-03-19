class ServicesController < ApplicationController
  layout 'laboratory'
  def index
    @departments = Department.find(:all)
    @services = Service.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @services }
    end
  end

  def new
    @service = Service.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @service }
    end
  end

  # GET /parameters/1/edit
  def edit
     @service = Service.find(params[:id])
  end
  
  def show
     @service = Service.find(params[:id])
  end

  # POST /parameters
  # POST /parameters.xml
  def create
    @service = Service.new(params[:service])

    respond_to do |format|
      if @service.save
        flash[:notice] = 'Service was successfully created.'
        format.html { redirect_to(@service) }
      else
        format.html { render :action => "new" }
      end
    end
  end

end
