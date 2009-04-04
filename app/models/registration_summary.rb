class RegistrationSummary < ActiveRecord::Base
   has_many :vital_signs
   has_many :patients ,:through => :vital_signs

end
