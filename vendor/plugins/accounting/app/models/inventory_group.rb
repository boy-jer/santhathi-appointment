class InventoryGroup < ActiveRecord::Base
  belongs_to :branch
  validates_presence_of :name, :branch_id
  validates_uniqueness_of :name, :scope => :branch_id
  attr_accessible :name, :description
end
