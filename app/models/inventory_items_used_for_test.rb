class InventoryItemsUsedForTest < ActiveRecord::Base
  belongs_to :service
  belongs_to :inventory_item
  validates_presence_of :inventory_item_id
end
