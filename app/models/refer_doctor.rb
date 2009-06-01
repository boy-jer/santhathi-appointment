class ReferDoctor < ActiveRecord::Base
   belongs_to :doctor
   belongs_to :appointment
end
