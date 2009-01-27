module AppointmentsHelper
  def iteration_count(doctor)
    dt1 = Time.parse(doctor.working_from.to_s)
    dt2 = Time.parse(doctor.working_to.to_s)
    return ((((dt2 - dt1)/60)/60)* 12).to_i
  end

  def appointments(doctor, date = nil)
    #All appointments for the day
    date = date.nil? ? Date.today : date
    app_list = {}
    appointments1 = doctor.appointments.on_date(date) 
    appointments1.collect {|appt| app_list[appt.appointment_time.strftime('%H:%M').to_s]= appt}

    return app_list
  end
  
  def doctors_list(dept_id = nil)
    if dept_id.nil?
      doctors = Doctor.find(:all).collect{|x| [x.doctor_name, x.id]}
    else
      doctors = Department.find(dept_id).doctors
    end
    
    return doctors
  end
  
  def hours
     b = []
     (0..23).step(1) do |num|
      b << num
     end
    return b
  end

  def minutes
     b = []
     (0..55).step(5) do |num|
      b << num
     end
    return b
  end
end
