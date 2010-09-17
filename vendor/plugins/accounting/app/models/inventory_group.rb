class InventoryGroup < ActiveRecord::Base  
  belongs_to :branch
  has_many :inventory_items
  validates_presence_of :name, :branch_id
  validates_uniqueness_of :name, :scope => :branch_id
  attr_accessible :name, :description
end
