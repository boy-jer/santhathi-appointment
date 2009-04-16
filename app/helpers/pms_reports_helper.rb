module PmsReportsHelper

	def departments_select_list_for_pms_report
  	 @all_departments = [["All Departments","All"]]
     @all_departments += Department.find(:all).collect{|model| [model.dept_name, model.id]}
     return @all_departments
  end

end
