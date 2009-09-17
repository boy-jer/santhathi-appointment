class Laboratory::PrescribedTestsController < ApplicationController

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
