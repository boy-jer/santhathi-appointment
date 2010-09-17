class AccountingPeriodAccountBalance < ActiveRecord::Base
  belongs_to :account
  belongs_to :accounting_period
  belongs_to :branch
  
  validates_presence_of :account_id, :accounting_period_id, :branch_id
  validates_uniqueness_of :account_id, :scope => :accounting_period_id
  validates_numericality_of :opening_balance
  validates_numericality_of :closing_balance, :allow_nil => true
end
