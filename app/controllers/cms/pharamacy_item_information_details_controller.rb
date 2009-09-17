class Cms::PharamacyItemInformationDetailsController < ApplicationController
	layout 'cms'

	before_filter :find_pharamacy_item_information




  def new
    @pharamacy_item_information_detail = PharamacyItemInformationDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pharamacy_item_information_detail }
    end
  end


  def edit
    @pharamacy_item_information_detail = PharamacyItemInformationDetail.find(params[:id])
  end


  def create
    @pharamacy_item_information_detail = PharamacyItemInformationDetail.new(params[:pharamacy_item_information_detail])
    @pharamacy_item_information_detail.pharamacy_item_information_id = @pharamacy_item_information.id

    respond_to do |format|
      if @pharamacy_item_information_detail.save
        flash[:notice] = 'PharamacyItemInformationDetail was successfully created.'
        format.html { redirect_to(cms_pharamacy_item_informations_path() )}
        format.xml  { render :xml => @pharamacy_item_information_detail, :status => :created, :location => @pharamacy_item_information_detail }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pharamacy_item_information_detail.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @pharamacy_item_information_detail = PharamacyItemInformationDetail.find(params[:id])

    respond_to do |format|
      if @pharamacy_item_information_detail.update_attributes(params[:pharamacy_item_information_detail])
        flash[:notice] = 'PharamacyItemInformationDetail was successfully updated.'
        format.html { redirect_to(cms_pharamacy_item_informations_path () ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pharamacy_item_information_detail.errors, :status => :unprocessable_entity }
      end
    end
  end




  private
  def find_pharamacy_item_information
  	@pharamacy_item_information = PharamacyItemInformation.find(params[:pharamacy_item_information_id])
 	end
end
