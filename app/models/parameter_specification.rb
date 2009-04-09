class ParameterSpecification < ActiveRecord::Base
  belongs_to :lab_test
  belongs_to :parameter
  acts_as_list :scope => :lab_test
end
