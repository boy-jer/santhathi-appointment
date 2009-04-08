class Sample < ActiveRecord::Base
	has_many :sample_specfications

	def self.samples_list
   	   self.find(:all).collect{|sample| [sample.sample_name, sample.id]}
    end

end
