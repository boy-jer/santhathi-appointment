module Admin::Masters::ParameterSpecificationsHelper

	def check(id)
		 @parameter = Parameter.find(id)
		 partial_name = case @parameter.value_type
                     when 'Text','Header' then 'text_fields'
                      when 'Numeric' then 'numeric_fields'
                      when 'Multiple' then 'multiple_fields'
                   end
        return  partial_name
   end
end

