class Laboratory::PrescriptionsController < ApplicationController
  layout 'laboratory'

  def index
    @search = Prescription.new_search(params[:search])
    @search.per_page ||= 15

    @search.order_as ||= "DESC"
    @search.order_by ||= [:p_date ,:p_time]
    @prescreptions = @search.all 

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
    @lab_test = Service.find(params[:test_id])
    @appointment = Appointment.find(params[:appointment])
    @department = Department.find_by_dept_name('Laboratory')
    @services = []
    respond_to do |format|
      format.html
      format.js { render :update do |page|
                    page.replace_html "test_#{@lab_test.id}", :partial => '/laboratory/prescriptions/new'
                    page.show "test_#{@lab_test.id}"
                    page.visual_effect(:highlight, "test_#{@lab_test.id}", :duration => 1)
                  end
                }
    end
  end


  def create
    @prescription = Prescription.new(params[:prescription])
    @lab_test = Service.find(params[:test_id])
    @department = Department.find(params[:prescription][:department_id])
    @appointment = Appointment.find(params[:prescription][:appointment_id])
    @lab_services = Service.lab_services.top_level
    @departments = Department.all
    @clinical_comments = ClinicalComment.find(:all, :conditions => "appointment_id in (#{@appointment.patient.appointments.collect{|p| p.id}})")
    @clinical_comment = @appointment.clinical_comment.blank? ? ClinicalComment.new : @appointment.clinical_comment
     @next_appointment_remark = @appointment.next_appointment_remark.blank? ? NextAppointmentRemark.new : @appointment.next_appointment_remark

    if @prescription.save
      @appointment.prescribe!
      params[:services].map{|service| PrescribedTest.create(:prescription_id => @prescription.id, :service_id => service)}
      @prescribed_tests = @prescription.prescribed_tests
      @services = @prescribed_tests.map{|p| p.service.id}
      respond_to do |format|  
        format.html
        format.js { render :update do |page|
                       #page.replace_html "test_#{@lab_test.id}", :partial => '/laboratory/prescriptions/edit'
                       page.replace_html "first_tab", :partial => 'cms/clinical_screens/first_tab'
                      # page.replace_html "prescription-list", :partial => '/laboratory/prescriptions/prescreptions'
                       #page.visual_effect(:highlight, 'clinical-screen', :duration => 0.5)
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
                    page.replace_html "test_#{@lab_test.id}", :partial => '/laboratory/prescriptions/edit'
                     page.show "test_#{@lab_test.id}"
                    page.visual_effect(:highlight, "test_#{@lab_test.id}", :duration => 1)
                  end
                }
    end
  end

   def update
     @prescription = Prescription.find(params[:id])
     @lab_test = Service.find(params[:test_id])
     @department = Department.find(params[:prescription][:department_id])
     @appointment = Appointment.find(params[:prescription][:appointment_id])
     @lab_services = Service.lab_services.top_level
     @departments = Department.all
     @clinical_comments = ClinicalComment.find(:all, :conditions => "appointment_id in (#{@appointment.patient.appointments.collect{|p| p.id}})")
     @clinical_comment = @appointment.clinical_comment.blank? ? ClinicalComment.new : @appointment.clinical_comment
     @next_appointment_remark = @appointment.next_appointment_remark.blank? ? NextAppointmentRemark.new : @appointment.next_appointment_remark
     if @prescription.save
        params[:services].map{|service| PrescribedTest.create(:prescription_id => @prescription.id, :service_id => service)}
        @prescribed_tests = @prescription.prescribed_tests
        @services = @prescribed_tests.map{|p| p.service.id}
        
        respond_to do |format|
          format.html
          format.js { render :update do |page|
                        page.replace_html "first_tab", :partial => 'cms/clinical_screens/first_tab'
                      end
                  }
        end
    end
   end

end
