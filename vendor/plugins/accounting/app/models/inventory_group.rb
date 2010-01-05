class InventoryGroup < ActiveRecord::Base
  belongs_to :branch
  validates_presence_of :name, :branch_id
  attr_accessible :name, :description
end
