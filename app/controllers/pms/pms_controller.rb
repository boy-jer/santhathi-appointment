class Pms::PmsController < ApplicationController
  layout 'cms'

  def index
    @pms = Pms.find(:all)
    redirect_to appointments_url
  end

  def show
    @pms = Pms.find(params[:id])
  end

  def new
    @pms = Pms.new
  end

  def edit
    @pms = Pms.find(params[:id])
  end

  def create
    @pms = Pms.new(params[:pms])
    if @pms.save
      flash[:notice] = 'Pms was successfully created.'
      redirect_to(@pms)
    else
      render :action => "new"
    end
  end

  def update
    @pms = Pms.find(params[:id])
	  if @pms.update_attributes(params[:pms])
      flash[:notice] = 'Pms was successfully updated.'
      redirect_to(@pms)
    else
      render :action => "edit"
    end
  end

  def destroy
    @pms = Pms.find(params[:id])
    @pms.destroy
	  redirect_to(pms_url)
  end


end
