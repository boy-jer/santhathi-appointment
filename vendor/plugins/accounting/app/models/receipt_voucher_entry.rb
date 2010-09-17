class ReceiptVoucherEntry < AccountTransaction
  attr_accessor :cash_or_bank_account_id
  attr_accessible :cash_or_bank_account_id
  before_validation_on_create :set_a_bank_or_cash_transaction_item
  
  has_one :debit_transaction_item, :conditions => "account_transaction_items.category = 'Debit'", :class_name => "AccountTransactionItem", :foreign_key => 'account_transaction_id'
  has_many :credit_transaction_items, :conditions => "account_transaction_items.category = 'Credit'", :class_name => "AccountTransactionItem", :foreign_key => 'account_transaction_id'

  private

  def set_a_bank_or_cash_transaction_item
    total_amt = 0
    account_transaction_items.each do |transaction_item|
      total_amt += transaction_item.amount unless transaction_item.amount.blank?
    end
    cash_or_bank_hash = {:account_id => cash_or_bank_account_id, :category => 'Debit', :amount => total_amt}
    bank_account_transaction_item = account_transaction_items.new(cash_or_bank_hash)
    bank_account_transaction_item.branch = branch
    bank_account_transaction_item.accounting_period = accounting_period
    self.account_transaction_items << bank_account_transaction_item
  end
end
