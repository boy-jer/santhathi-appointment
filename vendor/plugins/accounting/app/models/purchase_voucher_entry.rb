class PurchaseVoucherEntry < AccountTransaction
  attr_accessor :purchase_account_id, :purchase_effected_account_id
  attr_accessible :purchase_account_id, :purchase_effected_account_id
  before_validation_on_create :set_a_purchase_transaction_item

  has_one :debit_transaction_item, :conditions => "account_transaction_items.category = 'Debit'", :class_name => "AccountTransactionItem", :foreign_key => 'account_transaction_id'
  has_many :credit_transaction_items, :conditions => "account_transaction_items.category = 'Credit'", :class_name => "AccountTransactionItem", :foreign_key => 'account_transaction_id'

  private

  def set_a_purchase_transaction_item
    total_amt = 0
    inventory_transaction_items.each do |transaction_item|
      total_amt += transaction_item.total_price unless transaction_item.total_price.blank?
    end
    purchase_hash = {:account_id => purchase_account_id, :category => 'Debit', :amount => total_amt}
    bank_account_transaction_item = account_transaction_items.new(purchase_hash)
    bank_account_transaction_item.branch = branch
    bank_account_transaction_item.accounting_period = accounting_period

    purchase_effected_hash = {:account_id => purchase_effected_account_id, :category => 'Credit', :amount => total_amt}
    purchase_effected_transaction_item = account_transaction_items.new(purchase_effected_hash)
    purchase_effected_transaction_item.branch = branch
    purchase_effected_transaction_item.accounting_period = accounting_period

    self.account_transaction_items << bank_account_transaction_item
    self.account_transaction_items << purchase_effected_transaction_item
  end
end
