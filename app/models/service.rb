class Service < ActiveRecord::Base
  belongs_to :department
  acts_as_tree :order => "service_name"
end
