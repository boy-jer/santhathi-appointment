module Pms::PmsReportsHelper

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

  def month_print(month)
  	month_name= ["nil","January"," February"," March"," April"," May"," June"," July"," August"," September"," October"," November"," December"]
  	return month_name[month]
 	end

end
