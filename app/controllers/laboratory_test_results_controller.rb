class LaboratoryTestResultsController < ApplicationController
 layout 'laboratory'
 before_filter :find_all_things ,:only =>[:new,:show]
  def index
    @laboratory_test_results = LaboratoryTestResult.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @laboratory_test_results }
    end
  end

  # GET /laboratory_test_results/1
  # GET /laboratory_test_results/1.xml
  def show
    @laboratory_test_result = LaboratoryTestResult.find(:first,
           :conditions =>['appointment_id = ? AND prescription_id = ? AND lab_test_id = ?',
           params[:appointment_id],params[:prescription_id],params[:lab_test_id]])

    if @laboratory_test_result.nil?
      redirect_to(new_laboratory_test_result_path(:appointment_id=>@appointment.id,:prescription_id=> @prescription.id,:lab_test_id => @lab_test.id ))
    else
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @laboratory_test_result }
    end
   end
  end

  # GET /laboratory_test_results/new
  # GET /laboratory_test_results/new.xml

  def new
  	@appointment = Appointment.find(params[:appointment_id])
  	@prescription = Prescription.find(params[:prescription_id])
  	@lab_test = LabTest.find(params[:lab_test_id])
  	@laboratory_test_result = LaboratoryTestResult.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @laboratory_test_result }
    end
  end


  # GET /laboratory_test_results/1/edit
  def edit
    @laboratory_test_result = LaboratoryTestResult.find(params[:id])
  end


  def create
    @laboratory_test_result = LaboratoryTestResult.new(params[:laboratory_test_result])



    respond_to do |format|
      if @laboratory_test_result.save
        flash[:notice] = 'LaboratoryTestResult was successfully created.'
        format.html { redirect_to(:controller => 'laboratory_prescriptions',:action =>'index') }
        format.xml  { render :xml => @laboratory_test_result, :status => :created, :location => @laboratory_test_result }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @laboratory_test_result.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @laboratory_test_result = LaboratoryTestResult.find(params[:id])

    respond_to do |format|
      if @laboratory_test_result.update_attributes(params[:laboratory_test_result])
        flash[:notice] = 'LaboratoryTestResult was successfully updated.'
        format.html { redirect_to(@laboratory_test_result) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @laboratory_test_result.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @laboratory_test_result = LaboratoryTestResult.find(params[:id])
    @laboratory_test_result.destroy

    respond_to do |format|
      format.html { redirect_to(laboratory_test_results_url) }
      format.xml  { head :ok }
    end
  end
  private
  def find_all_things
  	@appointment = Appointment.find(params[:appointment_id])
  	@prescription = Prescription.find(params[:prescription_id])
  	@lab_test = LabTest.find(params[:lab_test_id])
  end


end
