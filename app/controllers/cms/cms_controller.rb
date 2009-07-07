class Cms::CmsController < ApplicationController
  layout 'cms'

  def index
    @cms = Cms.find(:all)
    redirect_to cms_doctor_patients_path(current_user.id)
  end

  def show
    @cms = Cms.find(params[:id])
  end

  def new
    @cms = Cms.new
  end

  def edit
    @cms = Cms.find(params[:id])
  end

  def create
    @cms = Cms.new(params[:cms])
    if @cms.save
      flash[:notice] = 'Cms was successfully created.'
      redirect_to(@cms)
    else
      render :action => "new"
    end
  end

  def update
    @cms = Cms.find(params[:id])
    if @cms.update_attributes(params[:cms])
      flash[:notice] = 'Cms was successfully updated.'
      redirect_to(@cms)
    else
      render :action => "edit"
    end
  end

  def destroy
    @cms = Cms.find(params[:id])
    @cms.destroy
    redirect_to(cms_url)
  end
end
