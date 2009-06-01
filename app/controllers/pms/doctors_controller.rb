class Pms::DoctorsController < ApplicationController
  layout 'pms'

  def index
    @search = Doctor.new_search(params[:search])
    @search.per_page ||= 15
    @doctors = @search.all
    respond_to do |format|
              format.html
              format.js {
                      render :update do |page|
                        page.replace_html 'doctor-list', :partial => 'doctors_list'
                      end
                      }
              end
  end

  def show
    @doctor = Doctor.find(params[:id])
  end

  def new
    @doctor = Doctor.new
  end

  def edit
    @doctor = Doctor.find(params[:id])
  end

  def create
    @doctor = Doctor.new(params[:doctor])
    if @doctor.save
      flash[:notice] = 'Doctor was successfully created.'
      redirect_to(pms_doctors_url)
    else
      render :action => "new"
    end
  end

  def update
    @doctor = Doctor.find(params[:id])
    if @doctor.update_attributes(params[:doctor])
      flash[:notice] = 'Doctor was successfully updated.'
      redirect_to(pms_doctors_url)
    else
      render :action => "edit"
    end
  end

  def destroy
    @doctor = Doctor.find(params[:id])
    @doctor.destroy
    redirect_to(pms_doctors_url)
  end
end
