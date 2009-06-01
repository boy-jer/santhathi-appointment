class Cms::PharmacyCourseListsController < ApplicationController
  layout 'cms'

  def index
    @pharmacy_course_lists = PharmacyCourseList.paginate :page => params[:page],:per_page => 10
  end

  def show
    @pharmacy_course_list = PharmacyCourseList.find(params[:id])
    render :layout => false
  end

  def new
    @pharmacy_course_list = PharmacyCourseList.new
  end

  def edit
    @pharmacy_course_list = PharmacyCourseList.find(params[:id])
  end

  def create
    @pharmacy_course_list = PharmacyCourseList.new(params[:pharmacy_course_list])
    if @pharmacy_course_list.save
      flash[:notice] = 'PharmacyCourseList was successfully created.'
      redirect_to(cms_pharmacy_course_lists_url)
    else
       render :action => "new"
    end
  end

  def update
    @pharmacy_course_list = PharmacyCourseList.find(params[:id])
    if @pharmacy_course_list.update_attributes(params[:pharmacy_course_list])
      flash[:notice] = 'PharmacyCourseList was successfully updated.'
      redirect_to(cms_pharmacy_course_lists_url)
    else
      render :action => "edit"
    end
  end

  def destroy
    @pharmacy_course_list = PharmacyCourseList.find(params[:id])
    @pharmacy_course_list.destroy
    redirect_to(cms_pharmacy_course_lists_url)
  end

end
