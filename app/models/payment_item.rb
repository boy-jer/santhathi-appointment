class PaymentItem < ActiveRecord::Base
  belongs_to :payable, :polymorphic => true
  belongs_to :payment

  attr_accessor :payable_name

  validates_presence_of :payable_id, :payable_type
  validates_numericality_of :amount, :total_amount, :quantity

  before_validation :set_payable_id
  after_create :transact_account_on_create

  private

  def set_payable_id
    self.payable_id = eval("#{payable_type}.find_by_name(payable_name).id") if payable_id.blank?
  end

  def transact_account_on_create
    cash_account = Account.find_by_name(CASH_AC[:name])
    cash_debit = {:category => 'Debit', :amount => total_amount, :account_id => cash_account.id}

    payment_account = payable.account
    payment_credit = {:category => 'Credit', :amount => total_amount, :account_id => payment_account.id}
 
    account_transaction_items_attributes = {"0" => payment_credit , "1" => cash_debit}

    inventory_transaction_items_attributes = {"0" => {:category => "Sale", :quantity => quantity, :price => amount, :total_price => total_amount, :inventory_item_id => payable.id, :unit_type => 'Sub'} }

    branch = DefaultBranch.get
    transaction = branch.account_transactions.build
    transaction.account_transaction_items_attributes = account_transaction_items_attributes
    transaction.account_transactionable = self.payable
    transaction.account_transactionable_on = 'Create'
    if payable_type == 'InventoryItem'
      transaction.inventory_transaction_items_attributes = inventory_transaction_items_attributes
    end
    transaction.save!
  end
end
