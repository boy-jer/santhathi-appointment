class Payment < ActiveRecord::Base
  include AASM
  belongs_to :appointment
  has_many :payment_items

  validates_presence_of :payment_items

  after_create :generate_appointment_bill

  accepts_nested_attributes_for :payment_items, :reject_if => proc { |attributes| ( attributes['payable_name'].blank?  ) }

  aasm_column :state
  aasm_initial_state :pending

  aasm_state :pending
  aasm_state :paid
  aasm_state :canceled


  aasm_event :recieve_payment do
    transitions :to => :paid, :from => [:pending], :on_transition => :receive_payments_transact
  end

  aasm_event :cancel_payment do
    transitions :to => :canceled, :from => [:pending], :on_transition => :cancel_appointment_bill
  end

  def total_bill_amount
    total_amt = 0.0
    payment_items.each do |pt|
      total_amt += pt.total_amount
    end
    return total_amt
  end

  private

  def receive_payments_transact    
    transact_account_on_pay
    pay_appointment_bill
  end

  def transact_account_on_pay
    cash_account = Account.find_by_name(CASH_AC[:name])
    cash_debit = {:category => 'Debit', :amount => total_bill_amount, :account_id => cash_account.id}

    payment_items.each do |payment_item|
      payment_account = payment_item.payable.account
      payment_credit = {:category => 'Credit', :amount => payment_item.total_amount, :account_id => payment_account.id}
 
      account_transaction_items_attributes = {"0" => payment_credit , "1" => cash_debit}

      inventory_transaction_items_attributes = {"0" => {:category => "Sale", :quantity => payment_item.quantity, :price => payment_item.amount, :total_price => payment_item.total_amount, :inventory_item_id => payment_item.payable.id, :unit_type => 'Sub'} }

      branch = DefaultBranch.get
      transaction = branch.account_transactions.build
      transaction.account_transaction_items_attributes = account_transaction_items_attributes
      transaction.account_transactionable = payment_item.payable
      transaction.account_transactionable_on = 'PaymentRecieve'
      if payment_item.payable_type == 'InventoryItem'
        transaction.inventory_transaction_items_attributes = inventory_transaction_items_attributes
      end
      transaction.save!
    end 
  end

  def generate_appointment_bill
    appointment.generate_bill! unless appointment.blank?
  end

  def cancel_appointment_bill
    appointment.cancel_bill! unless appointment.blank?
  end

  def pay_appointment_bill
    appointment.pay_bill! unless appointment.blank?
  end
end
