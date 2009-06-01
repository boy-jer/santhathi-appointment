class Pms::DepartmentsController < ApplicationController
  layout 'pms'

  def index
    @search = Department.new_search(params[:search])
    @search.per_page ||= 15
    @departments  = @search.all
    respond_to do |format|
                  format.html
                  format.js { render :update do |page|
                                page.replace_html 'department_list', :partial => 'departments_list'
                              end
                            }
    end
  end

  def show
    @department = Department.find(params[:id])
  end

  def new
    @department = Department.new
  end

  def edit
    @department = Department.find(params[:id])
  end

  def create
    @department = Department.new(params[:department])
    if @department.save
      flash[:notice] = 'Department was successfully created.'
      redirect_to(pms_departments_url)
    else
      render :action => "new"
    end
  end

  def update
    @department = Department.find(params[:id])
    if @department.update_attributes(params[:department])
      flash[:notice] = 'Department was successfully updated.'
      redirect_to(pms_departments_url)
    else
      render :action => "edit"
    end
  end

  def destroy
    @department = Department.find(params[:id])
    @department.destroy
    redirect_to(pms_departments_url)
  end
end
