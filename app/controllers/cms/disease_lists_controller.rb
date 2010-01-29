class Cms::DiseaseListsController < ApplicationController
  layout 'cms_single_column'
  require_role ["doctor", "admin"]

  def index
    @disease_lists = DiseaseList.paginate :page => params[:page],:per_page => 10
  end

  def show
    @disease_list = DiseaseList.find(params[:id])
    render :layout => false
  end

  def new
    @disease_list = DiseaseList.new
  end

  def edit
    @disease_list = DiseaseList.find(params[:id])
  end

  def create
    @disease_list = DiseaseList.new(params[:disease_list])
    if @disease_list.save
      flash[:notice] = 'DiseaseList was successfully created.'
      redirect_to(cms_disease_lists_url)
    else
      render :action => "new"
    end
  end

  def update
    @disease_list = DiseaseList.find(params[:id])
    if @disease_list.update_attributes(params[:disease_list])
      flash[:notice] = 'DiseaseList was successfully updated.'
      redirect_to(cms_disease_lists_url)
    else
      render :action => "edit"
    end
  end

  def destroy
    @disease_list = DiseaseList.find(params[:id])
    @disease_list.destroy
    redirect_to(cms_disease_lists_url)
  end

end

