class PharmacyDosageListsController < ApplicationController
   layout 'cms'
  def index
    @pharmacy_dosage_lists = PharmacyDosageList.paginate :page => params[:page],:per_page => 10

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pharmacy_dosage_lists }
    end
  end

  # GET /pharmacy_dosage_lists/1
  # GET /pharmacy_dosage_lists/1.xml
  def show
    @pharmacy_dosage_list = PharmacyDosageList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pharmacy_dosage_list }
        format.js { render :layout => false }
    end
  end

  # GET /pharmacy_dosage_lists/new
  # GET /pharmacy_dosage_lists/new.xml
  def new
    @pharmacy_dosage_list = PharmacyDosageList.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pharmacy_dosage_list }
    end
  end

  # GET /pharmacy_dosage_lists/1/edit
  def edit
    @pharmacy_dosage_list = PharmacyDosageList.find(params[:id])
  end

  # POST /pharmacy_dosage_lists
  # POST /pharmacy_dosage_lists.xml
  def create
    @pharmacy_dosage_list = PharmacyDosageList.new(params[:pharmacy_dosage_list])

    respond_to do |format|
      if @pharmacy_dosage_list.save
        flash[:notice] = 'PharmacyDosageList was successfully created.'
        format.html { redirect_to(@pharmacy_dosage_list) }
        format.xml  { render :xml => @pharmacy_dosage_list, :status => :created, :location => @pharmacy_dosage_list }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pharmacy_dosage_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pharmacy_dosage_lists/1
  # PUT /pharmacy_dosage_lists/1.xml
  def update
    @pharmacy_dosage_list = PharmacyDosageList.find(params[:id])

    respond_to do |format|
      if @pharmacy_dosage_list.update_attributes(params[:pharmacy_dosage_list])
        flash[:notice] = 'PharmacyDosageList was successfully updated.'
        format.html { redirect_to(@pharmacy_dosage_list) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pharmacy_dosage_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pharmacy_dosage_lists/1
  # DELETE /pharmacy_dosage_lists/1.xml
  def destroy
    @pharmacy_dosage_list = PharmacyDosageList.find(params[:id])
    @pharmacy_dosage_list.destroy

    respond_to do |format|
      format.html { redirect_to(pharmacy_dosage_lists_url) }
      format.xml  { head :ok }
    end
  end
end
