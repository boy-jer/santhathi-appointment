class PrescriptionsController < ApplicationController
  layout 'cms'

  def index


  end

  def new
    @prescription = Prescription.new
    @lab_test = LabTest.find(params[:test_id])
    @appointment = Appointment.find(params[:appointment])
    #@child_list = @lab_test.children
    @department = Department.find_by_dept_name('Laboratory')
    @prescribed_tests = @prescription.prescribed_tests

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
      	#if @department.dept_name == "laboratory" or @department.dept_name == "Laboratory"
       	 #params[:services].map{|service|
       	       #lab_test = LabTest.find_by_name(Service.find(service).name)
       	    #PrescribedTest.create(:prescription_id => @prescription.id, :service_id => lab_test.id )}
     	#else
           params[:services].map{|service| PrescribedTest.create(:prescription_id => @prescription.id, :service_id => service)}
       #end
        format.html
        format.js { render :update do |page|
                      page.replace_html 'clinical-screen', :partial => 'prescriptions/new', :object => @prescription_list
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
    
    #@child_list = @lab_test.children
    @department = Department.find_by_dept_name('Laboratory')
    @prescribed_tests = @prescription.prescribed_tests
    @services = @prescribed_tests.map{|p| p.service.id}

    respond_to do |format|
      format.html
      format.js { render :update do |page|
                    page.replace_html 'clinical-screen', :partial => 'prescriptions/new'
                  end
                }
    end
  end
end
