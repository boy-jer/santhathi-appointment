class Laboratory::PrescriptionsController < ApplicationController
  layout 'laboratory'

  def index
    #@search = Prescription.new_search(params[:search])
    #@search.per_page ||= 15
    #@prescriptions ,@count = @search.all, @search.count
    @search = PrescribedTest.new_search(params[:search])
    @search.per_page ||= 15
    @prescribed_tests, @count = @search.all(:include => {:prescriptions_tests => :prescriptions}), @search.count
    respond_to do |format|
      format.html
      format.js { render :update do |page|
                     page.replace_html 'prescription-list', :partial => '/laboratory/prescriptions/prescription_list'
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
                    page.replace_html 'clinical-screen', :partial => '/laboratory/prescriptions/new'
                  end
                }
    end
  end


  def create
    @prescription = Prescription.new(params[:prescription])
    @lab_test = LabTest.find(params[:test_id])
    @department = Department.find(params[:prescription][:department_id])
    @appointment = Appointment.find(params[:prescription][:appointment_id])

      if @prescription.save
        params[:services].map{|service| PrescribedTest.create(:prescription_id => @prescription.id, :lab_test_id => service)}
        @prescribed_tests = @prescription.prescribed_tests
        @services = @prescribed_tests.map{|p| p.lab_test.id}
        respond_to do |format|
          format.html
          format.js { render :update do |page|
                      page.replace_html 'clinical-screen', :partial => '/laboratory/prescriptions/edit'
                    end
                    }
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
                    page.replace_html 'clinical-screen', :partial => '/laboratory/prescriptions/edit'
                  end
                }
    end
  end

   def update
   	 @prescription = Prescription.find(params[:id])
     @lab_test = LabTest.find(params[:test_id])
     @department = Department.find(params[:prescription][:department_id])
     @appointment = Appointment.find(params[:prescription][:appointment_id])

     if @prescription.save
        params[:services].map{|service| PrescribedTest.create(:prescription_id => @prescription.id, :lab_test_id => service)}
        @prescribed_tests = @prescription.prescribed_tests
        @services = @prescribed_tests.map{|p| p.lab_test.id}
        respond_to do |format|
          format.html
          format.js { render :update do |page|
                      page.replace_html 'clinical-screen', :partial => '/laboratory/prescriptions/edit'
                      page.visual_effect(:highlight, 'clinical-screen', :duration => 0.5)
                    end
                  }
        end
    end
   end

end
