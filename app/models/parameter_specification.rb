class ParameterSpecification < ActiveRecord::Base
  belongs_to :lab_test
  belongs_to :parameter
  acts_as_list :scope => :lab_test

  named_scope :gender_filter, lambda{|gender| {:conditions => ["gender = ? or gender = ? ", gender,"both"] } }

end
