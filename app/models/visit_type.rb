class VisitType  < SelectOption
	validates_presence_of :name,:description

	def self.visit_type_list
	  self.find(:all).collect{|visit| [visit.name, visit.id] }
	end

end
