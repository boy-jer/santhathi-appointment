module Cms::PatientsHelper

 def row_class(name)
   class_name = case name
                #when "visited" then "color1"
                when "prescribed" then "color5"
                when "recommend_for_discharge" then "color3"
  		else ""
   end
   return class_name
  end


end
