class SalesVoucherEntry < AccountTransaction
  attr_accessor :sales_account_id
  attr_accessible :sales_account_id
  before_validation_on_create :set_a_sales_transaction_item

  has_one :credit_transaction_item, :conditions => "account_transaction_items.category = 'Credit'", :class_name => "AccountTransactionItem", :foreign_key => 'account_transaction_id'
  has_many :debit_transaction_items, :conditions => "account_transaction_items.category = 'Debit'", :class_name => "AccountTransactionItem", :foreign_key => 'account_transaction_id'

  private

  def set_a_sales_transaction_item
    total_amt = 0
    account_transaction_items.each do |transaction_item|
      total_amt += transaction_item.amount unless transaction_item.amount.blank?
    end
    sales_hash = {:account_id => sales_account_id, :category => 'Credit', :amount => total_amt}
    bank_account_transaction_item = account_transaction_items.new(sales_hash)
    bank_account_transaction_item.branch = branch
    bank_account_transaction_item.accounting_period = accounting_period
    self.account_transaction_items << bank_account_transaction_item
  end
end
