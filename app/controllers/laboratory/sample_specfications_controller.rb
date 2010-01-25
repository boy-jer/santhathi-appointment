class Laboratory::SampleSpecficationsController < ApplicationController
  layout 'laboratory_single_column'
  before_filter :find_lab_test

  def index
    @sample_specfications = @lab_test.sample_specfications.find(:all)
  end

  def show
    @sample_specfication = @lab_test.sample_specfications.find(params[:id])
    render :layout => false
  end

  def new
    @sample_specfication =   @lab_test.sample_specfications.new
  end

  def edit
    @sample_specfication = @lab_test.sample_specfications.find(params[:id])
  end

  def create
    @sample_specfication = @lab_test.sample_specfications.new(params[:sample_specfication])
    if @sample_specfication.save
      flash[:notice] = 'SampleSpecfication was successfully created.'
      redirect_to(laboratory_lab_test_sample_specfications_path(@lab_test))
    else
      render :action => "new"
    end
  end

  def update
    @sample_specfication =  @lab_test.sample_specfications.find(params[:id])
    if @sample_specfication.update_attributes(params[:sample_specfication])
      flash[:notice] = 'SampleSpecfication was successfully updated.'
      redirect_to(laboratory_lab_test_sample_specfications_path(@lab_test))
    else
      render :action => "edit"
    end
  end


  def destroy
    @sample_specfication = @lab_test.sample_specfications.find(params[:id])
    @sample_specfication.destroy
    redirect_to(laboratory_lab_test_sample_specfications_path(@lab_test))
  end


  private

  def find_lab_test
  	@lab_test = Service.find(params[:lab_test_id])
  end




end
