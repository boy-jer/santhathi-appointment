module Laboratory::LaboratoryTestResultsHelper

	def find_age_group(gender)
		if gender == 'm'
		  parameter_spec = @lab_test.parameter_specifications.find_by_gender("male")
	    else
	      parameter_spec = @lab_test.parameter_specifications.find_by_gender("female")
        end

	    if parameter_spec.nil?
	       parameter_spec = @lab_test.parameter_specifications.find_by_gender("both")
    	end
	    return parameter_spec
	end


    def find_measurement(name)
       name	= Parameter.find_by_parameter_name(name).measurement_unit.name
       return name
   	end

   	def find_doctor_name(id)
   		name = Doctor.find(id).name
   		return name
    end


end
