class ServicesController < ApplicationController
  layout 'cms'
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
    @parent = Service.find(params[:service][:parent_id]) unless params[:service][:parent_id].blank?
    @service.depth =  @parent.blank? ? 1 : @parent.depth + 1
    respond_to do |format|
      if @service.save
        flash[:notice] = 'Service was successfully created.'
        format.html { redirect_to(@service) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @service = Service.find(params[:id])

    respond_to do |format|
      if @service.update_attributes(params[:service])
        flash[:notice] = 'Service was successfully updated.'
        format.html { redirect_to(services_path ()) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @service.errors, :status => :unprocessable_entity }
      end
    end
  end

  def child_list
    @child_list = Department.find(params[:department]).services.find_all_by_parent_id(nil)

    render :update do |page|
       	page.replace_html 'child_list', :partial => 'child_list', :collection =>@child_list, :as => :service
    end
  end

  def destroy


    @service = Service.find(params[:id])
    @service.destroy

    respond_to do |format|
      format.html { redirect_to( services_path ()) }
      format.xml  { head :ok }
    end
  end


end
