class Cms::PatientHistoriesController < ApplicationController
  layout 'patient_history'
  before_filter :find_appointment ,:except =>[:show,:index,:prescribed_tests]

  def index
   @patient = Patient.find(65)
   @appointment = Appointment.find(6)
  end

  def show
    @patient = Patient.find(params[:id])
    @appointments = @patient.appointments.find(:all,:order => "created_at DESC")
  end

  def prescription
     prescription = @appointment.prescription
     @prescribed_tests = prescription.prescribed_tests
     render :update do |page|
       page.replace_html 'patient-history', :partial => 'cms/patient_histories/prescriptions'
     end
  end

  def reports
    @prescription = @appointment.prescription
    @prescribed_tests = @prescription.prescribed_tests
    render :update do |page|
      page.replace_html 'patient-history', :partial => 'cms/patient_histories/reports'
    end
  end

  def visit_report
    @appointment = Appointment.find(params[:appointment_id])
    @prescribed_tests = PrescribedTest.find(:all,:include =>[:prescription],:conditions =>['prescriptions.appointment_id = ?' ,@appointment.id])
  @next_appointment = Appointment.find(:last,:conditions => ['patient_id = ? and state =? and doctor_id = ?',@appointment.patient_id,"new_appointment",@appointment.doctor_id])
    @pharmacy_prescriptions = @appointment.pharmacy_prescriptions
    render :update do |page|
       page.replace_html 'visit-report', :partial => 'cms/patient_histories/visit_report'
     end
  end

  def pharmacy_prescription
    @pharmacy_prescriptions = @appointment.pharmacy_prescriptions
		    render :update do |page|
                        page.replace_html 'patient-history', :partial => 'cms/patient_histories/pharmacy_prescription'
                      end

	end

	def transfer_history

                     render :update do |page|
                        page.replace_html 'patient-history', :partial => 'cms/patient_histories/transfer_history'
                      end

	end

	def alerts
		     render :update do |page|
                        page.replace_html 'patient-history', :partial => 'cms/patient_histories/alerts'
                      end

	end

	def discharge_summary

    @discharge_summary = @appointment.discharge_summary

                     render :update do |page|

                        page.replace_html 'patient-history', :partial => 'cms/patient_histories/discharge_summary'
                      end

	end

	def clinical_comment
		@clinical_comment = @appointment.clinical_comment
		render :update do |page|
         page.replace_html 'patient-history', :partial => 'cms/patient_histories/clinical_comment'
    end

	end

	def prescribed_tests
		@prescribed_test = PrescribedTest.find(params[:prescribed_test_id])
    @prescription, @lab_test = @prescribed_test.prescription, @prescribed_test.service
    @appointment = @prescription.appointment
    @patient = @appointment.patient
    @specifications = @lab_test.parameter_specifications
    @laboratory_report = LaboratoryReport.find(params[:id])
    @laboratory_test_results =  @laboratory_report.laboratory_test_results
    @results = {}
    @laboratory_test_results.map{|r|  @results[r.parameter_specification_id] = [r.result, r.remarks] }
    render :update do |page|
         page.replace_html 'prescribed_test', :partial => 'cms/patient_histories/prescribed_tests'
    end
	end

	private

	def find_appointment
		@appointment = Appointment.find(params[:appointment_id])
	end

end
