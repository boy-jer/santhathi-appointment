class ParameterSpecification < ActiveRecord::Base
  belongs_to :service
  belongs_to :parameter
  has_one :laboratory_test_result
  acts_as_list :scope => :service

  named_scope :gender_filter, lambda{|gender| {:conditions => ["gender = ? or gender = ? ", gender,"both"] } }

end
