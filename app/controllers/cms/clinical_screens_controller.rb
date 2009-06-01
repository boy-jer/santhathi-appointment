class Cms::ClinicalScreensController < ApplicationController
  layout 'cms'

  def new
    unless params[:appointment_id].blank?
      @appointment = Appointment.find(params[:appointment_id])
      @patient = @appointment.patient
      @doctor = @appointment.doctor
      @lab_services = LabTest.find_all_by_parent_id(nil)
      @department = Department.find_by_dept_name("laboratory")
      @prescribed_tests = @appointment.prescription.prescribed_tests unless @appointment.prescription.blank?
      @last_visit_report  = last_visit_report(@appointment.id,@patient.id)
    else
      flash[:notice]=" Please select at least one appointment."
      redirect_to doctor_patients_path
    end
  end

  private

  def last_visit_report(appointment_id,patient_id)
    appointment_ids = Appointment.find(:all,:order =>'created_at ASC',:conditions => ['patient_id = ?',patient_id]).map { |a| a.id }
    c = appointment_ids.rindex(appointment_id)
    c = c-1
    if c >= 0
      appointment = Appointment.find(appointment_ids[c])
      last =  appointment.prescription.prescribed_tests unless appointment.prescription.blank?
      return last
    end
    return
  end

end