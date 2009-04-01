class Service < ActiveRecord::Base
  belongs_to :department
  has_many :prescribed_tests
  has_many :prescriptions, :through => :prescribed_tests

  acts_as_tree :order => "service_name"
end
