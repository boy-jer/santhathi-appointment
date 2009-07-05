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

    def laboratory_test_result(report_id, spec_id)
      LaboratoryTestResult.find_by_laboratory_report_id_and_parameter_specification_id(report_id, spec_id)
   	end

    def find_parameter_specification(lab_test_id,parameter_id)
      para_spec = ParameterSpecification.find_by_lab_test_id_and_parameter_id(lab_test_id,parameter_id)
      return para_spec
   	end

   	def laboratory_docator_list()
   		id = Department.find_by_dept_name('laboratory').id
   		DoctorProfile.find(:all,:conditions => ["department_id = ? ", id]).map { |ob| [ob.name,ob.doctor.id] }
  	end

end
