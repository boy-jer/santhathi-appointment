class AccountGroupType < ActiveRecord::Base
  has_many :account_groups
  has_many :main_account_groups, :conditions => "type = 'AccountMainGroup'", :class_name => 'AccountGroup'
  belongs_to :branch
  
  validates_presence_of :name, :branch_id  
  validates_uniqueness_of :name, :scope => :branch_id  
  
  attr_accessible :name, :description
end
