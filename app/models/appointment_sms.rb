class AppointmentSms < ActiveRecord::Base
  belongs_to :patient

  def self.send_message(patient_id,appointment_id)
    patient = Patient.find(patient_id)
    appointment = Appointment.find(appointment_id)
    sms = AppointmentSms.new
    sms.patient_id = patient_id
    sms.save
    Admin::MessageService.create(:sms => {:message_body=> "You have an appointment on #{appointment.appointment_date} #{appointment.appointment_time.strftime("at %I:%M%p")}.Department - #{appointment.department.dept_name},Doctor Name - #{appointment.doctor.doctor_profile.name}",:number => patient.contact_no})
  end
end

