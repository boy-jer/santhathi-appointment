module Laboratory::ParameterSpecificationsHelper

	def check(value_type)
		 partial_name = case value_type
                      when 'Text' then 'text_fields'
                      when 'Numeric' then 'numeric_fields'
                      when 'Multiple' then 'multiple_fields'
                   end
        return  partial_name
   end
end
