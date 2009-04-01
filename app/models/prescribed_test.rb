class PrescribedTest < ActiveRecord::Base
  belongs_to :service
  belongs_to :prescription 
end
