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
     @lab_test = LabTest.find(params[:id])
  end

  def show
    @lab_test = LabTest.find(params[:id])
  end

  # POST /parameters
  # POST /parameters.xml
  def create
    @lab_test = LabTest.new(params[:lab_test])
    @parent = LabTest.find(params[:lab_test][:parent_id]) unless params[:lab_test][:parent_id].blank?
    @lab_test.depth =  @parent.blank? ? 1 : @parent.depth.to_i + 1

    service_parent = Service.find_by_name(@parent.name) unless params[:lab_test][:parent_id].blank?
    service = Service.new
    service.name = params[:lab_test][:name]
    service.parent_id = service_parent
    service.depth =  service_parent.blank? ? 1 : service_parent.depth.to_i + 1
    service.department_id = Department.find_by_dept_name("laboratory").id
    service.save

    respond_to do |format|
      if  @lab_test.save
        flash[:notice] = 'Service was successfully created.'
        format.html { redirect_to(lab_tests_url) }
      else
        format.html { render :action => "new" }
      end
    end
  end


end
