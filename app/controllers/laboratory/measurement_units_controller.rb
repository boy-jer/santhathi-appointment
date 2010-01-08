class Laboratory::MeasurementUnitsController < ApplicationController
  layout proc{ |c| ['show','new', 'create'].include?(c.action_name)? 'laboratory_single_column' : 'laboratory'}

  def index
    @search = MeasurementUnit.new_search(params[:search])
    @search.per_page ||= 15
    @measurement_units  = @search.all
    respond_to do |format|
                  format.html
                  format.js { render :update do |page|
                                page.replace_html 'measurement_unit', :partial => 'measurement_units_list'
                              end
                            }
    end
  end

  def show
    @measurement_unit = MeasurementUnit.find(params[:id])
    render :layout => false
  end

  def new
    @measurement_unit = MeasurementUnit.new
  end

  def edit
    @measurement_unit = MeasurementUnit.find(params[:id])
  end

  def create
    @measurement_unit = MeasurementUnit.new(params[:measurement_unit])
    if @measurement_unit.save
      flash[:notice] = 'Measurement unit record is successfully created.'
      redirect_to(laboratory_measurement_units_url)
    else
      render :action => "new"
    end
  end

  def update
    @measurement_unit = MeasurementUnit.find(params[:id])
    if @measurement_unit.update_attributes(params[:measurement_unit])
      flash[:notice] = 'Measurement unit record is successfully updated.'
      redirect_to(laboratory_measurement_units_url)
    else
      render :action => "edit"
    end
  end

  def destroy
    @measurement_unit = MeasurementUnit.find(params[:id])
    @measurement_unit.destroy
    redirect_to(laboratory_measurement_units_url)
  end

end
