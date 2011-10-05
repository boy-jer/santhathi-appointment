class InventoryItem < ActiveRecord::Base
  belongs_to :branch
  belongs_to :inventory_unit_of_measurement
  belongs_to :inventory_group
  belongs_to :account
  belongs_to :pharmacy_dosage_list
  belongs_to :pharmacy_course_list
  has_many :inventory_transaction_items

  validates_presence_of :name, :inventory_group_id, :inventory_unit_of_measurement_id
  validates_numericality_of :current_quantity, :allow_nil => true
  validates_numericality_of :unit_buy_price, :unit_sale_price, :allow_nil => true
  validates_numericality_of :opening_quantity

  attr_accessible :name, :unit_buy_price, :unit_sale_price, :consumable, :shelf_no
  attr_accessible :discount_allowed, :sub_unit_sale_price, :opening_quantity
  attr_accessible :unit_sale_net_price, :unit_sale_vat_price, :sub_unit_sale_net_price
  attr_accessible :sub_unit_sale_vat_price, :vat_percent, :account_id
  attr_accessible :pharmacy_dosage_list_id, :course_duration,  :quantity 		
  attr_accessible :pharmacy_course_list_id, :inventory_group_id, :other_remarks


  named_scope :non_consumables, :conditions => {:consumable => false}

  def cumulative_current_quantity    
    current_quantity + opening_quantity
  end
end
