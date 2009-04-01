class LabTestsController < ApplicationController
  layout 'laboratory'

  def index
   @tests = LabTest.find(:all)
   @child_list = LabTest.find_all_by_parent_id(nil)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tests }
    end
  end

  def new
    @lab_test = LabTest.new
    @child_list = LabTest.find_all_by_parent_id(nil)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @lab_test }
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
    @lab_test = LabTest.new(params[:lab_test])
    @parent = Service.find(params[:lab_test][:parent_id]) unless params[:lab_test][:parent_id].blank?
    @lab_test.depth =  @parent.blank? ? 1 : @parent.depth.to_i + 1
    respond_to do |format|
      if  @lab_test.save
        flash[:notice] = 'Service was successfully created.'
        format.html { redirect_to(lab_tests_url) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def child_list
    @child_list = Department.find(params[:department]).services.find_all_by_parent_id(nil)
    render :update do |page|
      page.replace_html 'child_list', :partial => 'child_list', :collection =>@child_list, :as => :service
    end
  end

end
