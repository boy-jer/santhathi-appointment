class Account < ActiveRecord::Base    
  belongs_to :account_group   
  belongs_to :branch  
  has_many :account_balances
  has_many :account_transaction_items
  has_many :account_transactions, :through => :account_transaction_items
  has_many :accounting_period_account_balances
  
  validates_presence_of :account_group, :name, :branch_id
  validates_numericality_of :current_balance, :opening_balance
 # validate :current_balance_as_positive  

  after_create :set_account_balances
  # after_update :update_accounting_period_account_balance

  attr_accessible :name, :branch_id, :current_balance, :opening_balance

  named_scope :bank_cash_accounts, :joins => :account_group, :conditions => "account_groups.name in ('Cash-in Hand', 'Bank Accounts')"
  named_scope :non_bank_cash_accounts, :joins => :account_group, :conditions => "account_groups.name not in ('Cash-in Hand', 'Bank Accounts')"

  named_scope :sales_accounts, :joins => :account_group, :conditions => "account_groups.name in ('Sales Account')"
  named_scope :non_sales_accounts, :joins => :account_group, :conditions => "account_groups.name not in ('Sales Account')"

  named_scope :purchase_accounts, :joins => :account_group, :conditions => "account_groups.name in ('Purchases Account')"
  named_scope :non_purchase_accounts, :joins => :account_group, :conditions => "account_groups.name not in ('Purchases Account')"

  def cumulative_current_balance
    return (current_balance + opening_balance)
  end

  #should not be in after_update
  def update_accounting_period_account_balance
    accounting_period_account_balance = accounting_period_account_balances.find_by_accounting_period_id(branch.current_accounting_period.id)
    accounting_period_account_balance.opening_balance = opening_balance
    accounting_period_account_balance.save!
  end
  
  protected
  def current_balance_as_positive
    errors.add(:current_balance, "cannot be less than zero") if !current_balance.blank? and current_balance < 0
  end

  def set_account_balances
    account_balance = account_balances.build
    account_balance.for_date = branch.default_current_open_day.for_date
    account_balance.accounting_period = branch.current_accounting_period
    account_balance.branch = branch
    account_balance.accounting_day_id = branch.default_current_open_day_id
    account_balance.closing_balance = account_balance.opening_balance = 0
    account_balance.save!

    accounting_period_account_balance = accounting_period_account_balances.build
    accounting_period_account_balance.accounting_period = branch.current_accounting_period
    accounting_period_account_balance.branch = branch
    accounting_period_account_balance.opening_balance = opening_balance
    accounting_period_account_balance.save!
  end
end
