class PharamacyItemInformationsController < ApplicationController
    layout 'cms'

  def index
    @pharamacy_item_informations = PharamacyItemInformation.paginate :page => params[:page],:per_page => 10

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pharamacy_item_informations }
    end
  end

  # GET /pharamacy_item_informations/1
  # GET /pharamacy_item_informations/1.xml
  def show
    @pharamacy_item_information = PharamacyItemInformation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pharamacy_item_information }
       format.js { render :layout => false }
    end
  end

  # GET /pharamacy_item_informations/new
  # GET /pharamacy_item_informations/new.xml
  def new
    @pharamacy_item_information = PharamacyItemInformation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pharamacy_item_information }
    end
  end

  # GET /pharamacy_item_informations/1/edit
  def edit
    @pharamacy_item_information = PharamacyItemInformation.find(params[:id])
  end

  # POST /pharamacy_item_informations
  # POST /pharamacy_item_informations.xml
  def create
    @pharamacy_item_information = PharamacyItemInformation.new(params[:pharamacy_item_information])

    respond_to do |format|
      if @pharamacy_item_information.save
        flash[:notice] = 'PharamacyItemInformation was successfully created.'
        format.html { redirect_to(@pharamacy_item_information) }
        format.xml  { render :xml => @pharamacy_item_information, :status => :created, :location => @pharamacy_item_information }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pharamacy_item_information.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pharamacy_item_informations/1
  # PUT /pharamacy_item_informations/1.xml
  def update
    @pharamacy_item_information = PharamacyItemInformation.find(params[:id])

    respond_to do |format|
      if @pharamacy_item_information.update_attributes(params[:pharamacy_item_information])
        flash[:notice] = 'PharamacyItemInformation was successfully updated.'
        format.html { redirect_to(@pharamacy_item_information) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pharamacy_item_information.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pharamacy_item_informations/1
  # DELETE /pharamacy_item_informations/1.xml
  def destroy
    @pharamacy_item_information = PharamacyItemInformation.find(params[:id])
    @pharamacy_item_information.destroy

    respond_to do |format|
      format.html { redirect_to(pharamacy_item_informations_url) }
      format.xml  { head :ok }
    end
  end
end
