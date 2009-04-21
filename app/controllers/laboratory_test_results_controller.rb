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
    @appointment = Appointment.find(params[:appointment_id])
    @prescription = Prescription.find(params[:prescription_id])
    @lab_test = LabTest.find(params[:lab_test_id])

    @patient = @appointment.patient
    @specifications = @lab_test.parameter_specifications

    @laboratory_test_results = LaboratoryTestResult.find(:all, :conditions =>['appointment_id = ? AND prescription_id = ? AND lab_test_id = ?',                params[:appointment_id], params[:prescription_id], params[:lab_test_id]] )
    @results = {}
    @laboratory_test_results.map{|r|  @results[r.parameter_specification_id] = [r.result, r.remarks] }
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @laboratory_test_results}
    end
  end

  # GET /laboratory_test_results/new
  # GET /laboratory_test_results/new.xml

  def new
    @appointment = Appointment.find(params[:appointment_id])
    @prescription = Prescription.find(params[:prescription_id])
    @lab_test = LabTest.find(params[:lab_test_id])

    @patient = @appointment.patient
    @specifications = @lab_test.parameter_specifications

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
    specs = params[:specifications]

    specs[:ids].each_pair{ |key, value|
                          @laboratory_test_result = LaboratoryTestResult.new(params[:laboratory_test_result])
                          @laboratory_test_result.parameter_specification_id = key
                          @laboratory_test_result.result = value
                          @laboratory_test_result.remarks = specs[:remarks]["r_#{key}"]
                          @laboratory_test_result.save
                         }
                          flash[:notice] = 'LaboratoryTestResult was successfully created.'
                          redirect_to(:controller => 'laboratory_prescriptions', :action =>'index')
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

  def details
    @patient = Patient.find(params[:patient_id])
    @parameter_specification = ParameterSpecification.find(params[:specification_id])
    respond_to do |format|
      format.js { render :layout => false }
    end
  end


  private
  def find_all_things
  	@appointment = Appointment.find(params[:appointment_id])
  	@prescription = Prescription.find(params[:prescription_id])
  	@lab_test = LabTest.find(params[:lab_test_id])
  end


end
