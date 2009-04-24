class ClinicalScreensController < ApplicationController
 layout 'cms'

  def new
     unless params[:appointment_id].blank?
       @appointment = Appointment.find(params[:appointment_id])
       @patient = @appointment.patient
       @doctor = @appointment.doctor
       @lab_services = LabTest.find_all_by_parent_id(nil)
       @department = Department.find_by_dept_name("laboratory")
     #  @prescription = @appointment.prescription
       @prescribed_tests = @appointment.prescription.prescribed_tests unless @appointment.prescription.blank?
     else
      flash[:notice]=" Please select at least one appointment."
      redirect_to doctor_patients_path
    end
  end



end
