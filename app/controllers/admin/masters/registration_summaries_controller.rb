class Admin::Masters::RegistrationSummariesController < ApplicationController
  layout 'admin_single_column'

  def index
    @registration_summaries = RegistrationSummary.paginate :page => params[:page],:per_page => 10
  end

  def show
    @registration_summary = RegistrationSummary.find(params[:id])

  end

  def new
    @registration_summary = RegistrationSummary.new

  end

  def edit
    @registration_summary = RegistrationSummary.find(params[:id])
  end

  def create
    @registration_summary = RegistrationSummary.new(params[:registration_summary])
    if @registration_summary.save
      flash[:notice] = 'RegistrationSummary was successfully created.'
      redirect_to(admin_masters_registration_summaries_url)
    else
      render :action => "new"
    end
  end

  def update
    @registration_summary = RegistrationSummary.find(params[:id])
    if @registration_summary.update_attributes(params[:registration_summary])
      flash[:notice] = 'RegistrationSummary was successfully updated.'
      redirect_to(admin_masters_registration_summaries_url)
    else
      render :action => "edit"
    end
  end

  def destroy
    @registration_summary = RegistrationSummary.find(params[:id])
    @registration_summary.destroy
    redirect_to(admin_masters_registration_summaries_url)
  end

end

