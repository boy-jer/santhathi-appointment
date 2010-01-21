class Payment < ActiveRecord::Base
  belongs_to :appointment
  has_many :payment_items

  validates_presence_of :payment_items

  accepts_nested_attributes_for :payment_items, :reject_if => proc { |attributes| ( attributes['payable_name'].blank?  ) }

end
