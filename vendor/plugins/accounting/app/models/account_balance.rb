class AccountBalance < ActiveRecord::Base
  belongs_to :account  
  belongs_to :accounting_period
  belongs_to :branch  
  belongs_to :accounting_day
  
  validates_numericality_of :opening_balance 
  validates_numericality_of :closing_balance, :allow_nil => true
  validates_presence_of :accounting_period_id, :branch_id, :for_date
  validates_uniqueness_of :account_id, :scope => :accounting_day_id
 # validate :amounts_as_positive
  
  protected
  
  def amounts_as_positive
    errors.add(:opening_balance, "cannot be less than zero") if !opening_balance.blank? and opening_balance < 0
    errors.add(:closing_balance, "cannot be less than zero") if !closing_balance.blank? and closing_balance < 0            
  end  
end
