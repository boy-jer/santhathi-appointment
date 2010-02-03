class InventoryItemsUsedForTest < ActiveRecord::Base
  belongs_to :service
  validates_presence_of :inventory_item_id
end
