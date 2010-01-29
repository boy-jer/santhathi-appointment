class Cms::PharmacyDosageListsController < ApplicationController
  layout 'cms_single_column'
  def index
    @pharmacy_dosage_lists = PharmacyDosageList.paginate :page => params[:page],:per_page => 10
  end

  def show
    @pharmacy_dosage_list = PharmacyDosageList.find(params[:id])
    render :layout => false
  end

  def new
    @pharmacy_dosage_list = PharmacyDosageList.new

  end

  def edit
    @pharmacy_dosage_list = PharmacyDosageList.find(params[:id])
  end

  def create
    @pharmacy_dosage_list = PharmacyDosageList.new(params[:pharmacy_dosage_list])
    if @pharmacy_dosage_list.save
      flash[:notice] = 'PharmacyDosageList was successfully created.'
      redirect_to(cms_pharmacy_dosage_lists_url)
    else
      render :action => "new"
    end
  end

  def update
    @pharmacy_dosage_list = PharmacyDosageList.find(params[:id])
    if @pharmacy_dosage_list.update_attributes(params[:pharmacy_dosage_list])
      flash[:notice] = 'PharmacyDosageList was successfully updated.'
      redirect_to(cms_pharmacy_dosage_lists_url)
    else
      render :action => "edit"
    end
  end

  def destroy
    @pharmacy_dosage_list = PharmacyDosageList.find(params[:id])
    @pharmacy_dosage_list.destroy
    redirect_to(cms_pharmacy_dosage_lists_url)
  end

end

