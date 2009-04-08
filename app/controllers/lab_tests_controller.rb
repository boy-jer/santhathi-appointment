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
    lab_test = params[:lab_test]
    @lab_test = LabTest.new(lab_test)
    parent = LabTest.find(lab_test[:parent_id]) unless lab_test[:parent_id].blank?
    @lab_test.depth = parent.depth.to_i + 1

    service_parent = Service.find_by_name(parent.name) unless lab_test[:parent_id].blank?

    respond_to do |format|
      if @lab_test.save
        Service.create( :name => lab_test[:name], :parent_id => service_parent.id, :depth => service_parent.depth.to_i + 1, :department_id => Department.find_by_dept_name("laboratory").id)

        flash[:notice] = 'Service was successfully created.'
        format.html { redirect_to(lab_tests_url) }
      else
        format.html { render :action => "new" }
      end
    end
  end


end
