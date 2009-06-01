class Cms::PatientHistoriesController < ApplicationController
  layout 'cms'
  before_filter :find_appointment ,:only =>[:discharge_summary ,:clinical_comment ,:prescription_and_reports ,:pharmacy_prescription]

  def index
  	@patient = Patient.find(4)
  	@appointment = Appointment.find(5)
  end




  def show
  	@appointment = Appointment.find(params[:appointment_id])
  	@prescription = @appointment.prescription
  	@prescribed_tests = @prescription.prescribed_tests
  	@clinical_screen = @appointment.clinical_screen
  	@laboratory_test_results = @appointment.laboratory_test_results

  	render :layout =>false
  end

  def soap


                     render :update do |page|
                        page.replace_html 'patient-history', :partial => 'cms/patient_histories/soap'
                      end

 	end


 	def prescription_and_reports
 		@prescription = @appointment.prescription
 		@prescribed_tests = @prescription.prescribed_tests

                     render :update do |page|
                        page.replace_html 'patient-history', :partial => 'cms/patient_histories/prescription_and_reports'
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

	private

	def find_appointment
		@appointment = Appointment.find(params[:appointment_id])
	end

end
