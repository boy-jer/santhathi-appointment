class Service < ActiveRecord::Base
  belongs_to :department
  has_and_belongs_to_many :prescriptions
  acts_as_tree :order => "service_name"
end
