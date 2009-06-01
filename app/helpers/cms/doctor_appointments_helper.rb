module Cms::DoctorAppointmentsHelper
  def reason_class(name)
       class_name = case name
                     when "Consultation" then "appointment1"
                     when "Councelling" then "appointment2"
                     when "Registration" then "appointment3"
                     when "UltraSound" then 'appointment4'
                     when "Andrology" then 'appointment5'
                     when "Embrology" then 'appointment6'
                     when "Laboratory" then 'appointment7'
                     when "Multiple" then 'appointment8'
                     when "Visited" then 'appointment9'
                     else 'appointment'
         end
        return class_name
   end
end
