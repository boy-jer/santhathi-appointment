class Cms::PrescriptionsController < ApplicationController
  def index
    @search = Prescription.new_search(params[:search])
    @search.per_page ||= 15

    @search.order_as ||= "DESC"
    @search.order_by ||= [:p_date ,:p_time]
    @prescreptions = @search.all 

    respond_to do |format|
      format.html
      format.js { render :update do |page|
                     page.replace_html 'other-prescription-list', :partial => '/cms/prescriptions/prescription_list'
                  end
                }
    end
  end

  def new
    @prescription = Prescription.new
    @lab_test = Service.find(params[:test_id])
    @appointment = Appointment.find(params[:appointment])
    @department = @lab_test.department
    @services = []
    respond_to do |format|
      format.html
      format.js { render :update do |page|
                    page.replace_html "service_#{@lab_test.id}", :partial => '/cms/prescriptions/new'
                    page.show "service_#{@lab_test.id}"
                    page.visual_effect(:highlight, "service_#{@lab_test.id}", :duration => 1)
                  end
                }
    end
  end


  def create
    @prescription = Prescription.new(params[:prescription])
    @lab_test = Service.find(params[:test_id])
    @department = Department.find(params[:prescription][:department_id])
    @appointment = Appointment.find(params[:prescription][:appointment_id])

    if @prescription.save
      @appointment.prescribe! unless @appointment.prescribed?
      params[:services].map{|service| PrescribedTest.create(:prescription_id => @prescription.id, :service_id => service)}
      @prescribed_tests = @prescription.prescribed_tests
      @services = @prescribed_tests.map{|p| p.service.id}
      respond_to do |format|  
        format.html
        format.js { render :update do |page|
                       page.replace_html "service_#{@lab_test.id}", :partial => '/laboratory/prescriptions/edit'
                       page.replace_html "prescription-list", :partial => '/laboratory/prescriptions/prescreptions'
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
    @department =  @lab_test.department
    @prescribed_tests = @prescription.prescribed_tests
    @services = @prescribed_tests.map{|p| p.service.id}
    

    respond_to do |format|
      format.html
      format.js { render :update do |page|
                    page.replace_html "service_#{@lab_test.id}", :partial => '/cms/prescriptions/edit'
                     page.show "service_#{@lab_test.id}"
                    page.visual_effect(:highlight, "service_#{@lab_test.id}", :duration => 1)
                  end
                }
    end
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
                        page.replace_html "service_#{@lab_test.id}", :partial => '/laboratory/prescriptions/edit'
                        page.replace_html "prescription-list", :partial => '/laboratory/prescriptions/prescreptions'
                        page.visual_effect(:highlight, 'clinical-screen', :duration => 0.5)
                      end
                  }
        end
    end
   end

end
