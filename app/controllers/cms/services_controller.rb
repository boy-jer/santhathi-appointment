class Cms::ServicesController < ApplicationController
 layout proc{ |c| ['show','new', 'create','edit'].include?(c.action_name)? 'cms_single_column' : 'cms'}
  def index
    @departments = Department.find(:all)
    @search = Service.new_search(params[:search])
    @services = @search.all
    respond_to do |format|
          format.html
          format.js {
                      render :update do |page|
                        page.replace_html 'service-list', :partial => 'service_result'
                      end
                    }
    end
  end

  def new
    @service = Service.new
  end

  def edit
    @service = Service.find(params[:id])
  end

  def show
    @service = Service.find(params[:id])
  end

  def create
    @service = Service.new(params[:service])
    @parent = Service.find(params[:service][:parent_id]) unless params[:service][:parent_id].blank?
    @service.depth =  @parent.blank? ? 1 : @parent.depth + 1
    if @service.save
      flash[:notice] = 'Service was successfully created.'
      redirect_to(cms_services_path)
    else
      render :action => "new"
    end
  end

  def update
    @service = Service.find(params[:id])
    if @service.update_attributes(params[:service])
      flash[:notice] = 'Service was successfully updated.'
      redirect_to(cms_services_path ())
    else
      render :action => "edit"
    end
  end

  def child_list
    unless department.blank?
      @child_list = Department.find(params[:department]).services.find_all_by_parent_id(nil)
      render :update do |page|
       	page.replace_html 'child_list', :partial => 'child_list', :collection =>@child_list, :as => :service
      end
    end
  end

  def destroy
    @service = Service.find(params[:id])
    @service.destroy
    redirect_to(cms_services_path ())
  end
end

