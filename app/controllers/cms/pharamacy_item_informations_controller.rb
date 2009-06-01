class Cms::PharamacyItemInformationsController < ApplicationController
  layout 'cms'

  def index
    @search = PharamacyItemInformation.new_search(params[:search])
    @search.per_page ||= 15
    @pharamacy_item_informations  = @search.all
    respond_to do |format|
                  format.html
                  format.js { render :update do |page|
                                page.replace_html 'pharmacy_item_list', :partial => 'pharmacy_item_informaion_list'
                              end
                            }
    end
  end

  def show
    @pharamacy_item_information = PharamacyItemInformation.find(params[:id])
    render :layout => false
  end

  def new
    @pharamacy_item_information = PharamacyItemInformation.new
  end

  def edit
    @pharamacy_item_information = PharamacyItemInformation.find(params[:id])
  end

  def create
    @pharamacy_item_information = PharamacyItemInformation.new(params[:pharamacy_item_information])
    if @pharamacy_item_information.save
      flash[:notice] = 'PharamacyItemInformation was successfully created.'
      redirect_to(cms_pharamacy_item_informations_url)
    else
      render :action => "new"
    end
  end

  def update
    @pharamacy_item_information = PharamacyItemInformation.find(params[:id])
    if @pharamacy_item_information.update_attributes(params[:pharamacy_item_information])
      flash[:notice] = 'PharamacyItemInformation was successfully updated.'
      redirect_to(cms_pharamacy_item_informations_url)
    else
      render :action => "edit"
    end
  end

  def destroy
    @pharamacy_item_information = PharamacyItemInformation.find(params[:id])
    @pharamacy_item_information.destroy
    redirect_to(cms_pharamacy_item_informations_url)
  end

end
