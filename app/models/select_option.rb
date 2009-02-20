class SelectOption < ActiveRecord::Base

   def self.factory(type, params = nil)
     type ||= 'SelectOption'
     model_name = type.constantize
     if defined? model_name
       model_name.new(params)
     else
       SelectOption.new(params)
     end
   end 

   def self.select_list()
     self.find(:all).collect{|x| [x.name, x.id]}
   end
end
