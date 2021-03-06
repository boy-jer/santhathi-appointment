class InventoryTransactionItem < ActiveRecord::Base
  belongs_to :branch
  belongs_to :accounting_day
  belongs_to :accounting_period
  belongs_to :inventory_item
  belongs_to :account_transaction

  validates_presence_of :category, :unit_type, :quantity, :inventory_opening_stock_quantity, :inventory_item_id
  validates_presence_of :inventory_closing_stock_quantity

  attr_accessor :inventory_item_name
  attr_accessible :inventory_item_name, :quantity, :price, :total_price, :category, :unit_type, :inventory_item_id

  before_validation :set_inventory_item, :set_inventory_item_balances
  before_save :set_transaction_date_and_type
  after_save :update_current_quantity_in_inventory_items

  private

  def set_inventory_item
    self.inventory_item = branch.inventory_items.find_by_name(inventory_item_name) if inventory_item_id.blank?
  end

  def set_inventory_item_balances
    self.inventory_opening_stock_quantity = inventory_item.current_quantity
    quantity_change = 0
    case category
      when "Purchase"
        self.inventory_closing_stock_quantity = inventory_item.current_quantity + quantity
        self.current_quantity = quantity
      when "Sale"
        if unit_type == 'Sub'
          quantity_change = quantity.quo(inventory_item.inventory_unit_of_measurement.unit_value)
        elsif unit_type == 'Main'
          quantity_change = quantity
        end
        self.inventory_closing_stock_quantity = inventory_item.current_quantity - quantity_change
      when "LaboratoryUse"
        if unit_type == 'Sub'
          quantity_change = quantity.quo(inventory_item.inventory_unit_of_measurement.unit_value)
        elsif unit_type == 'Main'
          quantity_change = quantity
        end
        self.inventory_closing_stock_quantity = inventory_item.current_quantity - quantity_change      
    end
  end

  def set_transaction_date_and_type
    self.branch = account_transaction.branch unless account_transaction.blank?
    self.accounting_day_id = branch.default_current_open_day.id 
    self.transaction_date = accounting_day.for_date
  end

  def update_current_quantity_in_inventory_items
    inventory_item.update_attribute(:current_quantity, inventory_closing_stock_quantity)
  end
end
