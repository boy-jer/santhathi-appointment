class LaboratoryReportsController < ApplicationController
  # GET /laboratory_reports
  # GET /laboratory_reports.xml
  layout 'laboratory'

  def index
   
  end


  def show
    @prescribed_test = PrescribedTest.find(params[:prescribed_test_id])
    @prescription, @lab_test = @prescribed_test.prescription, @prescribed_test.lab_test
    @appointment = @prescription.appointment
    @patient = @appointment.patient
    #@specifications = @lab_test.parameter_specifications
    @laboratory_report = LaboratoryReport.find(params[:id])
    @laboratory_test_results =  @laboratory_report.laboratory_test_results
    @results = {}
    @laboratory_test_results.map{|r|  @results[r.parameter_specification_id] = [r.result, r.remarks] }
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @laboratory_test_results}
    end
  end

  def new
    @prescribed_test = PrescribedTest.find(params[:prescribed_test_id])
    @prescription, @lab_test = @prescribed_test.prescription, @prescribed_test.lab_test
    @appointment = @prescription.appointment
    @patient = @appointment.patient
    @specifications = @lab_test.parameter_specifications

    @laboratory_report = LaboratoryReport.new
  end

  def edit
    @laboratory_report = LaboratoryReport.find(params[:id])
  end

  
  def create
    @laboratory_report = LaboratoryReport.new(params[:laboratory_report])
    @laboratory_report.save

    specs = params[:specifications]
    specs[:ids].each_pair{ |key, value| LaboratoryTestResult.create(:parameter_specification_id => key, 
                                                                   :result => value, 
                                                                   :remarks => specs[:remarks]["r_#{key}"],
                                                                   :laboratory_report_id =>  @laboratory_report.id ) }
    flash[:notice] = 'Report was successfully created.'                       
    redirect_to prescriptions_url
  end

  
  def update
    @laboratory_report = LaboratoryReport.find(params[:id])

    respond_to do |format|
      if @laboratory_report.update_attributes(params[:laboratory_report])
        flash[:notice] = 'LaboratoryReport was successfully updated.'
        format.html { redirect_to(@laboratory_report) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @laboratory_report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /laboratory_reports/1
  # DELETE /laboratory_reports/1.xml
  def destroy
    @laboratory_report = LaboratoryReport.find(params[:id])
    @laboratory_report.destroy

    respond_to do |format|
      format.html { redirect_to(laboratory_reports_url) }
      format.xml  { head :ok }
    end
  end
end
