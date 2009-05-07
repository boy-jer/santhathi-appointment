class PrescriptionsController < ApplicationController
  layout 'laboratory'

  def index
     @search = Prescription.new_search(params[:search])
     @search.per_page ||= 15
     @prescriptions = @search.all
     respond_to do |format|
       format.html
       format.js { render :update do |page|
                      page.replace_html 'prescription-list', :partial => 'prescription_list'
                   end
                 }
     end
  end

  def new
    @prescription = Prescription.new
    @lab_test = LabTest.find(params[:test_id])
    @appointment = Appointment.find(params[:appointment])
    @department = Department.find_by_dept_name('Laboratory')
    @services = []
    respond_to do |format|
      format.html
      format.js { render :update do |page|
                    page.replace_html 'clinical-screen', :partial => 'prescriptions/new'
                  end
                }
    end
  end


  def create
    @prescription = Prescription.new(params[:prescription])
    @lab_test = LabTest.find(params[:test_id])
    @department = Department.find(params[:prescription][:department_id])
    @appointment = Appointment.find(params[:prescription][:appointment_id])
    @prescribed_tests = @prescription.prescribed_tests

    respond_to do |format|
      if @prescription.save
        params[:services].map{|service| PrescribedTest.create(:prescription_id => @prescription.id, :lab_test_id => service)}
        format.html
        format.js { render :update do |page|
                      page.replace_html 'clinical-screen', :partial => 'prescriptions/edit'
                    end
                  }
      else
        format.html { redirect_to clinical_screen_doctor_patients_url(:id => @appointment) }
      end
    end
  end

  def edit
    @appointment = Appointment.find(params[:appointment])
    @prescription = @appointment.prescription
    @lab_test = LabTest.find(params[:test_id])
    @department = Department.find_by_dept_name('Laboratory')
    @prescribed_tests = @prescription.prescribed_tests
    @services = @prescribed_tests.map{|p| p.lab_test.id}

    respond_to do |format|
      format.html
      format.js { render :update do |page|
                    page.replace_html 'clinical-screen', :partial => 'prescriptions/edit'
                  end
                }
    end
  end

   def update
   	 @prescription = Prescription.find(params[:id])
   	  respond_to do |format|
       if @prescription.update_attributes(params[:prescription])
       	   params[:services].map{|service| PrescribedTest.create(:prescription_id => @prescription.id, :lab_test_id => service)}

        redirect_to (clinical_screen_doctor_patients_url(:id =>@prescription.appointment.id))
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @prescription.errors, :status => :unprocessable_entity }
      end
     end
  end

end
