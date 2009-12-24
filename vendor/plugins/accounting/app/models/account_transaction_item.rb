class AccountTransactionItem < ActiveRecord::Base
  attr_accessor :account_name
  belongs_to :accounting_period
  belongs_to :account_transaction
  belongs_to :account
  belongs_to :branch
  
  validates_presence_of :account_id, :category, :amount, :branch_id, :accounting_period_id
  validates_presence_of :account_opening_balance, :account_closing_balance
  validates_numericality_of :account_opening_balance, :account_closing_balance
  validates_numericality_of :amount, :greater_than => 0
  
  validate :category_value  
  validate :amounts_as_positive
  attr_accessible :account_id, :category, :amount, :account_name  #TODO: must remove :account_id from attr_accessible list
  before_validation :set_account, :set_account_balances
  before_save :set_transaction_date_and_type    
  after_save :update_current_balance_in_accounts, :update_closing_balance_in_account_balances

  def self.calculate_closing_balance(account, balance, amount, category)
    account_group_type = account.account_group.under_group_type
    case account_group_type
      when "Assets"
        if category == 'Credit'
          account_closing_balance = balance - amount          
        elsif category == 'Debit'
          account_closing_balance = balance + amount
        end  
      when "Liabilities"
        if category == 'Credit'
          account_closing_balance = balance + amount
        elsif category == 'Debit'
          account_closing_balance = balance - amount        
        end
      when "Income"
        if category == 'Credit'
          account_closing_balance = balance + amount        
        elsif category == 'Debit'
          account_closing_balance = balance - amount        
        end
      when "Expense"
        if category == 'Credit'
          account_closing_balance = balance - amount        
        elsif category == 'Debit'
          account_closing_balance = balance + amount        
        end
    end
    return account_closing_balance
  end
      
  protected
  
  def category_value
    errors.add(:category, "must be either 'Debit' or 'Credit'") unless ['Debit', 'Credit'].include?(category)
  end
  
  def amounts_as_positive
    errors.add(:amount, "cannot be less than zero") if !amount.blank? and amount < 0
#    errors.add(:account_opening_balance, "cannot be less than zero") if !account_opening_balance.blank? and account_opening_balance < 0
#    errors.add(:account_closing_balance, "cannot be less than zero") if !account_closing_balance.blank? and account_closing_balance < 0            
  end
  
  def set_account_balances
    return if amount.blank?
    account_group_type = account.account_group.under_group_type
    write_attribute(:account_opening_balance, account.current_balance)
    account_closing_balance = 0
    case account_group_type
      when "Assets"
        if category == 'Credit'
          account_closing_balance = account.current_balance - amount          
        elsif category == 'Debit'
          account_closing_balance = account.current_balance + amount
        end  
      when "Liabilities"
        if category == 'Credit'
          account_closing_balance = account.current_balance + amount
        elsif category == 'Debit'
          account_closing_balance = account.current_balance - amount        
        end
      when "Income"
        if category == 'Credit'
          account_closing_balance = account.current_balance + amount        
        elsif category == 'Debit'
          account_closing_balance = account.current_balance - amount        
        end
      when "Expense"
        if category == 'Credit'
          account_closing_balance = account.current_balance - amount        
        elsif category == 'Debit'
          account_closing_balance = account.current_balance + amount        
        end
    end
    write_attribute(:account_closing_balance, account_closing_balance)
  end

  def set_transaction_date_and_type
    write_attribute(:transaction_date, account_transaction.transaction_date)
    t_type = 'G'
    t_type = 'C' if account.account_group.name == 'Cash-in Hand' 
    write_attribute(:transaction_type, t_type)
  end
  
  def update_current_balance_in_accounts  
    account.update_attribute(:current_balance, account_closing_balance)
  end

  def update_closing_balance_in_account_balances
    account.account_balances.find_by_accounting_day_id(branch.default_current_open_day).update_attribute(:closing_balance, account_closing_balance)
  end

  def set_account
    self.account = branch.accounts.find_by_name(account_name) if account_id.blank?
  end 
end
