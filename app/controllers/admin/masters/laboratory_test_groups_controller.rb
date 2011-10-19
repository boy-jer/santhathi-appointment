class Admin::Masters::LaboratoryTestGroupsController < ApplicationController
   layout proc{ |c| ['show','new', 'create','edit'].include?(c.action_name)? 'admin_single_column' : 'admin'}

  def index
   @search = LaboratoryTestGroup.new_search(params[:search])
    @search.per_page ||= 50
    @laboratory_test_groups = @search.all
    respond_to do |format|
      format.html
      format.js  {  render :update do |page|
                      page.replace_html 'parameters_list', :partial => 'parameters_list'
                    end
                 }
     end
  end

  # GET /laboratory_test_groups/1
  # GET /laboratory_test_groups/1.xml
  def show
    @laboratory_test_group = LaboratoryTestGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @laboratory_test_group }
    end
  end

  # GET /laboratory_test_groups/new
  # GET /laboratory_test_groups/new.xml
  def new
    @laboratory_test_group = LaboratoryTestGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @laboratory_test_group }
    end
  end

  # GET /laboratory_test_groups/1/edit
  def edit
    @laboratory_test_group = LaboratoryTestGroup.find(params[:id])
  end

  # POST /laboratory_test_groups
  # POST /laboratory_test_groups.xml
  def create
    @laboratory_test_group = LaboratoryTestGroup.new(params[:laboratory_test_group])

    respond_to do |format|
      if @laboratory_test_group.save
        flash[:notice] = 'LaboratoryTestGroup was successfully created.'
        format.html { redirect_to admin_masters_laboratory_test_groups_path }
        format.xml  { render :xml => @laboratory_test_group, :status => :created, :location => @laboratory_test_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @laboratory_test_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /laboratory_test_groups/1
  # PUT /laboratory_test_groups/1.xml
  def update
    @laboratory_test_group = LaboratoryTestGroup.find(params[:id])

    respond_to do |format|
      if @laboratory_test_group.update_attributes(params[:laboratory_test_group])
        flash[:notice] = 'LaboratoryTestGroup was successfully updated.'
        format.html { redirect_to admin_masters_laboratory_test_groups_path}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @laboratory_test_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /laboratory_test_groups/1
  # DELETE /laboratory_test_groups/1.xml
  def destroy
    @laboratory_test_group = LaboratoryTestGroup.find(params[:id])
    @laboratory_test_group.destroy

    respond_to do |format|
      format.html { redirect_to(laboratory_test_groups_url) }
      format.xml  { head :ok }
    end
  end
end
