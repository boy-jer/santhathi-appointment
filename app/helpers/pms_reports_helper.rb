module PmsReportsHelper

  def count(counts, date)
    counts.keys.include?(date)? counts[date] : '0'
  end


  def count_first_visit(date)
  	 count = 0
  	 count = Appointment.count(:conditions=>['appointment_date = ? and visit_type = ?',date,"yes"])
  	 @count_visit_type += count
  	 return count
  end

  def count_follow_up(date)
  	count = 0
  	count = Appointment.count(:conditions=>['appointment_date = ? and visit_type = ?',date,"no"])
  	@count_visit_type += count
  	return count
  end

end
