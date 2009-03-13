class PharmacyCourseListsController < ApplicationController
   layout 'cms'
  def index
    @pharmacy_course_lists = PharmacyCourseList.paginate :page => params[:page],:per_page => 10

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pharmacy_course_lists }
    end
  end

  # GET /pharmacy_course_lists/1
  # GET /pharmacy_course_lists/1.xml
  def show
    @pharmacy_course_list = PharmacyCourseList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pharmacy_course_list }
        format.js { render :layout => false }
    end
  end

  # GET /pharmacy_course_lists/new
  # GET /pharmacy_course_lists/new.xml
  def new
    @pharmacy_course_list = PharmacyCourseList.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pharmacy_course_list }
    end
  end

  # GET /pharmacy_course_lists/1/edit
  def edit
    @pharmacy_course_list = PharmacyCourseList.find(params[:id])
  end

  # POST /pharmacy_course_lists
  # POST /pharmacy_course_lists.xml
  def create
    @pharmacy_course_list = PharmacyCourseList.new(params[:pharmacy_course_list])

    respond_to do |format|
      if @pharmacy_course_list.save
        flash[:notice] = 'PharmacyCourseList was successfully created.'
        format.html { redirect_to(@pharmacy_course_list) }
        format.xml  { render :xml => @pharmacy_course_list, :status => :created, :location => @pharmacy_course_list }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pharmacy_course_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pharmacy_course_lists/1
  # PUT /pharmacy_course_lists/1.xml
  def update
    @pharmacy_course_list = PharmacyCourseList.find(params[:id])

    respond_to do |format|
      if @pharmacy_course_list.update_attributes(params[:pharmacy_course_list])
        flash[:notice] = 'PharmacyCourseList was successfully updated.'
        format.html { redirect_to(@pharmacy_course_list) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pharmacy_course_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pharmacy_course_lists/1
  # DELETE /pharmacy_course_lists/1.xml
  def destroy
    @pharmacy_course_list = PharmacyCourseList.find(params[:id])
    @pharmacy_course_list.destroy

    respond_to do |format|
      format.html { redirect_to(pharmacy_course_lists_url) }
      format.xml  { head :ok }
    end
  end
end
