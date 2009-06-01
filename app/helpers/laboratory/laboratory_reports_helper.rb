module Laboratory::LaboratoryReportsHelper

    def display_parameter_specification(lab_test_id,parameter_id)
		para_spec = ParameterSpecification.find_by_lab_test_id_and_parameter_id(lab_test_id,parameter_id)
		unless para_spec.blank?
		  result = nil
	      unless (para_spec.min_value.blank? && para_spec.max_value.blank?)
		     result = para_spec.min_value + "-" + para_spec.max_value + "\n" + para_spec.special_condition
	      else
	    	 result = para_spec.special_condition
          end
		  return result
	   end
    end

    def find_parameter_specification(lab_test_id,parameter_id)
      para_spec = ParameterSpecification.find_by_lab_test_id_and_parameter_id(lab_test_id,parameter_id)
      return para_spec
   	end

end
