class SampleSpecficationsController < ApplicationController
 layout 'laboratory'
 before_filter :find_lab_test


  def index

    @sample_specfications = @lab_test.sample_specfications.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sample_specfications }
    end
  end

  def show
    @sample_specfication = @lab_test.sample_specfications.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sample_specfication }
    end
  end


  def new

    @sample_specfication =   @lab_test.sample_specfications.new


    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sample_specfication }
    end
  end


  def edit
    @sample_specfication = @lab_test.sample_specfications.find(params[:id])
  end


  def create
    @sample_specfication = @lab_test.sample_specfications.new(params[:sample_specfication])

    respond_to do |format|
      if @sample_specfication.save
        flash[:notice] = 'SampleSpecfication was successfully created.'
        format.html { redirect_to([@lab_test,@sample_specfication]) }
        format.xml  { render :xml => @sample_specfication, :status => :created, :location =>[@lab_test, @sample_specfication] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sample_specfication.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @sample_specfication =  @lab_test.sample_specfications.find(params[:id])

    respond_to do |format|
      if @sample_specfication.update_attributes(params[:sample_specfication])
        flash[:notice] = 'SampleSpecfication was successfully updated.'
        format.html { redirect_to([@lab_test,@sample_specfication]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sample_specfication.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @sample_specfication = @lab_test.sample_specfications.find(params[:id])
    @sample_specfication.destroy

    respond_to do |format|
      format.html { redirect_to(lab_test_sample_specfications_path(@lab_test)) }
      format.xml  { head :ok }
    end
  end


  private
  def find_lab_test
  	@lab_test = LabTest.find(params[:lab_test_id])
  end




end
