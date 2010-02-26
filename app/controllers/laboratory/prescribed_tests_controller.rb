class Laboratory::PrescribedTestsController < ApplicationController
  layout 'laboratory'

  def index

    @search = PrescribedTest.new_search(params[:search])
    @search.per_page ||= 15
    @search.order_as ||= "DESC"
    @search.order_by ||= "created_at"
    @prescribed_tests  = @search.all(:include => {:prescribed_tests => :service}) 
    respond_to do |format|
      format.html
      format.js { render :update do |page|
                    page.replace_html 'prescription-list', :partial => '/laboratory/prescribed_tests/prescription_list'
                  end
                }
    end
  end

  def new
    @prescription = Prescription.new
    @lab_test = Service.find(params[:test_id])
    @appointment = Appointment.find(params[:appointment])
    @department = Department.find_by_dept_name('Laboratory')
    @services = []
    respond_to do |format|
      format.html
      format.js { render :update do |page|
                    page.replace_html 'clinical-screen', :partial => '/laboratory/prescribed_tests/new'
                  end
                }
    end
  end


  def create
    @prescription = Prescription.new(params[:prescription])
    @lab_test = Service.find(params[:test_id])
    @department = Department.find(params[:prescription][:department_id])
    @appointment = Appointment.find(params[:prescription][:appointment_id])

    @appointment.prescribe!
    if @prescription.save
      params[:services].map{ |service| PrescribedTest.create(:prescription_id => @prescription.id, :service_id => service ) }
      @prescribed_tests = @prescription.prescribed_tests
      @services = @prescribed_tests.map{|p| p.service.id }
      respond_to do |format|
        format.html
        format.js { render :update do |page|
                      page.replace_html 'clinical-screen', :partial => '/laboratory/prescribed_tests/edit'
                      page.visual_effect(:highlight, 'clinical-screen', :duration => 0.5)
                    end

                    }
         end
      end


  end

  def edit
    @appointment = Appointment.find(params[:appointment])
    @prescription = @appointment.prescription
    @lab_test = Service.find(params[:test_id])
    @department = Department.find_by_dept_name('Laboratory')
    @prescribed_tests = @prescription.prescribed_tests
    @services = @prescribed_tests.map{|p| p.service.id}

    respond_to do |format|
      format.html
      format.js { render :update do |page|
                    page.replace_html 'clinical-screen', :partial => '/laboratory/prescribed_tests/edit'
                  end
                }
    end
  end

  def show
    @prescribed_test = PrescribedTest.find(params[:id])
    render :layout => false
  end

   def update
   	 @prescription = Prescription.find(params[:id])
     @lab_test = Service.find(params[:test_id])
     @department = Department.find(params[:prescription][:department_id])
     @appointment = Appointment.find(params[:prescription][:appointment_id])

     if @prescription.save
        params[:services].map{|service| PrescribedTest.create(:prescription_id => @prescription.id, :service_id => service)}
        @prescribed_tests = @prescription.prescribed_tests
        @services = @prescribed_tests.map{|p| p.service.id}
        respond_to do |format|
          format.html
          format.js { render :update do |page|
                        page.replace_html 'clinical-screen', :partial => '/laboratory/prescribed_tests/edit'
                        page.visual_effect(:highlight, 'clinical-screen', :duration => 0.5)
                      end
                  }
        end
    end
   end

  def destroy
    @prescribe_test = PrescribedTest.find(params[:id])
    @appointment = @prescribe_test.prescription.appointment
    @prescribe_test.destroy
    redirect_to new_cms_appointment_clinical_screen_path(@appointment)
  end

=begin
def destroy
	  @prescribe_test = PrescribedTest.find(params[:id])
	  @prescretion = @prescribe_test.prescription

      @prescribe_test.destroy

      @prescribe_tests = @prescretion.prescribed_tests

     respond_to do |format|
        # format.html { redirect_to clinical_screen_doctor_patients_url(:id => @appointment) }

        format.js { render :update do |page|
                      page.replace_html 'prescription-list', :partial => 'prescriptions/prescreptions', :object => @prescribe_tests
                    end
                  }
	end
  end
=end


end

