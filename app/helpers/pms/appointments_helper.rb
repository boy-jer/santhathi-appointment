module  Pms::AppointmentsHelper

  def iteration_count(doctor)
    dt1 = Time.parse(doctor.doctor_profile.working_from.to_s)
    dt2 = Time.parse(doctor.doctor_profile.working_to.to_s)
    return ((((dt2 - dt1)/60)/60)* 12).to_i
  end

  def doctors_list(dept_id = nil)
    if dept_id.nil?
      @doctors = Doctor.find(:all).collect{|x| [x.doctor_profile.name, x.id]}
    else
      @doctors = Department.find(dept_id).doctors.collect{|x| [x.doctor_profile.name, x.id]}
    end
    return @doctors
  end

 

  def status(original_state)
    show_state = case original_state
                 when 'new_appointment' then 'New'
                 when 'recommend_for_discharge' then 'Discharge Rec.'
                 else original_state.camelize
     end
  end

  def appointment_date(date)
    "#{Time.parse(date.to_s).strftime('%b %d, %Y')} : #{Date::DAYNAMES[date.to_date.wday]}"
  end
end
