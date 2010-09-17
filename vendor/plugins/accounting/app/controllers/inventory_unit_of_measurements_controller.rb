class InventoryUnitOfMeasurementsController < ApplicationController
  layout 'inventory'
  # GET /inventory_unit_of_measurements
  # GET /inventory_unit_of_measurements.xml
  def index
    @inventory_unit_of_measurements = user_default_branch.inventory_unit_of_measurements.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @inventory_unit_of_measurements }
    end
  end

  # GET /inventory_unit_of_measurements/1
  # GET /inventory_unit_of_measurements/1.xml
  def show
    @inventory_unit_of_measurements = user_default_branch.inventory_unit_of_measurements.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @inventory_unit_of_measurements }
    end
  end

  # GET /inventory_unit_of_measurements/new
  # GET /inventory_unit_of_measurements/new.xml
  def new
    @inventory_unit_of_measurements = user_default_branch.inventory_unit_of_measurements.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @inventory_unit_of_measurements }
    end
  end

  # GET /inventory_unit_of_measurements/1/edit
  def edit
    @inventory_unit_of_measurements = user_default_branch.inventory_unit_of_measurements.find(params[:id])
  end

  # POST /inventory_unit_of_measurements
  # POST /inventory_unit_of_measurements.xml
  def create
    @inventory_unit_of_measurements = user_default_branch.inventory_unit_of_measurements.build(params[:inventory_unit_of_measurement])

    respond_to do |format|
      if @inventory_unit_of_measurements.save
        flash[:notice] = 'InventoryUnitOfMeasurements was successfully created.'
        format.html { redirect_to(@inventory_unit_of_measurements) }
        format.xml  { render :xml => @inventory_unit_of_measurements, :status => :created, :location => @inventory_unit_of_measurements }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @inventory_unit_of_measurements.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /inventory_unit_of_measurements/1
  # PUT /inventory_unit_of_measurements/1.xml
  def update
    @inventory_unit_of_measurements = user_default_branch.inventory_unit_of_measurements.find(params[:id])

    respond_to do |format|
      if @inventory_unit_of_measurements.update_attributes(params[:inventory_unit_of_measurement])
        flash[:notice] = 'InventoryUnitOfMeasurements was successfully updated.'
        format.html { redirect_to(@inventory_unit_of_measurements) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @inventory_unit_of_measurements.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_unit_of_measurements/1
  # DELETE /inventory_unit_of_measurements/1.xml
  def destroy
    @inventory_unit_of_measurements = user_default_branch.inventory_unit_of_measurements.find(params[:id])
    @inventory_unit_of_measurements.destroy

    respond_to do |format|
      format.html { redirect_to(inventory_unit_of_measurements_url) }
      format.xml  { head :ok }
    end
  end
end
