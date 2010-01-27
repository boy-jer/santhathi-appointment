class Cms::ClinicalScreensController < ApplicationController
  layout 'cms_single_column'
  require_role ["doctor", "admin"]

  def new
    unless params[:appointment_id].blank?
      @appointment = Appointment.find(params[:appointment_id])

      @prescription = @appointment.prescription
      @patient = @appointment.patient
      @doctor = @appointment.doctor
      @lab_services = Service.lab_services.top_level
      @department = Department.find_by_dept_name("laboratory")
      @departments = Department.all
      unless @appointment.prescription.blank?
        @prescribed_lab_tests = @prescription.prescribed_tests.by_laboratory_dept(@department.id)
        @prescribed_services = @prescription.prescribed_tests.by_other_dept(@department.id)
      end

      @clinical_comments = ClinicalComment.find(:all, :conditions => "appointment_id in (#{@appointment.patient.appointments.collect{|p| p.id}})")
      @clinical_comment = @appointment.clinical_comment.blank? ? ClinicalComment.new : @appointment.clinical_comment
      @next_appointment_remark = @appointment.next_appointment_remark.blank? ? NextAppointmentRemark.new : @appointment.next_appointment_remark
    else
      flash[:notice]=" Please select at least one appointment."
       redirect_to cms_doctor_patients_path(current_user.id)
    end
  end
  

  private

  def last_visit_report(appointment_id, patient)
    appointments = patient.appointments(:order => 'created_at DESC')
    appointments[1].prescription.prescribed_tests unless appointments[1].blank?
    #appointment_ids = Appointment.find(:all, :order =>'created_at ASC', :conditions => ['patient_id = ?', patient_id]).map{|a| a.id }
    #c = appointment_ids.rindex(appointment_id)
    #c = c-1
    #if c >= 0
      #appointment = Appointment.find(appointment_ids[c])
      #last =  appointment.prescription.prescribed_tests unless appointment.prescription.blank?
      #return last
    #end
    #return
  end

end
