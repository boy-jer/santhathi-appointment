class MeasurementUnitsController < ApplicationController
  layout 'laboratory'

  def index
    @measurement_units = MeasurementUnit.paginate :page => params[:page],:per_page => 10

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @measurement_units }
    end
  end

  # GET /measurement_units/1
  # GET /measurement_units/1.xml
  def show
    @measurement_unit = MeasurementUnit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @measurement_unit }
    end
  end

  # GET /measurement_units/new
  # GET /measurement_units/new.xml
  def new
    @measurement_unit = MeasurementUnit.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @measurement_unit }
    end
  end

  # GET /measurement_units/1/edit
  def edit
    @measurement_unit = MeasurementUnit.find(params[:id])
  end

  # POST /measurement_units
  # POST /measurement_units.xml
  def create
    @measurement_unit = MeasurementUnit.new(params[:measurement_unit])

    respond_to do |format|
      if @measurement_unit.save
        flash[:notice] = 'MeasurementUnit was successfully created.'
        format.html { redirect_to(@measurement_unit) }
        format.xml  { render :xml => @measurement_unit, :status => :created, :location => @measurement_unit }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @measurement_unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /measurement_units/1
  # PUT /measurement_units/1.xml
  def update
    @measurement_unit = MeasurementUnit.find(params[:id])

    respond_to do |format|
      if @measurement_unit.update_attributes(params[:measurement_unit])
        flash[:notice] = 'MeasurementUnit was successfully updated.'
        format.html { redirect_to(@measurement_unit) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @measurement_unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /measurement_units/1
  # DELETE /measurement_units/1.xml
  def destroy
    @measurement_unit = MeasurementUnit.find(params[:id])
    @measurement_unit.destroy

    respond_to do |format|
      format.html { redirect_to(measurement_units_url) }
      format.xml  { head :ok }
    end
  end
end
