module Laboratory::LaboratoryReportsHelper

    def display_parameter_specification(lab_test_id,parameter_id)
		para_spec = ParameterSpecification.find_by_service_id_and_parameter_id(lab_test_id,parameter_id)
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
      para_spec = ParameterSpecification.find_by_service_id_and_parameter_id(lab_test_id,parameter_id)
      return para_spec
   	end

   	def laboratory_docator_list()
   		id = Department.find_by_dept_name('laboratory').id
   		DoctorProfile.find(:all,:conditions => ["department_id = ? ", id]).map { |ob| [ob.name,ob.doctor.id] }
  	end

   def multivalues(parameter)
     vals = parameter.parameter_values
     vals.nil? ? [] : vals.map{|v| v.value}
   end

   def lab_report_for_other_prescribed_test(service, laboratory_report )
     @other_specifications = service.parameter_specifications.gender_filter(@patient.gender)
     laboratory_report = laboratory_report
     laboratory_test_results =  laboratory_report.laboratory_test_results
     results = {}
     laboratory_test_results.map{|r|  results[r.parameter_specification_id] = [r.result, r.remarks] }
     return results
   end

end

