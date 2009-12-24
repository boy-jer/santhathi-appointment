class AccountingPeriod < ActiveRecord::Base
  include AASM
  has_many :account_transactions
  has_many :account_transaction_items
  has_many :account_balances
  has_many :account_days
  has_many :accounting_period_account_balances

  belongs_to :company
  belongs_to :branch
    
  validates_presence_of :name, :branch_id
  validates_uniqueness_of :name, :scope => :branch_id  
  validate_on_create :overlapping_periods
  validate :open_accounting_period_as_unique_for_branch
  
  attr_accessible :name, :start_date, :end_date
    
  aasm_column :state
  aasm_initial_state :Open
  aasm_state :Open
  aasm_state :Closed  
  
  aasm_event :close do
    transitions :to => :Closed, :from => [:Open], :on_transition => :process_accounting_period_closure
  end

  aasm_event :re_open do
    transitions :to => :Open, :from => [:Closed], :on_transition => :process_accounting_period_re_open
  end

  after_create :set_branch_default_current_accounting_period, :create_new_accounting_period_account_balances
    
  def self.set_up_accounting_period(branch, date_for=Date.today)
    accounting_start_year = (date_for.month > 3 ? date_for.year : (date_for.year - 1))
    accounting_end_year = (date_for.month > 3 ? (date_for.year + 1) : date_for.year)
    accounting_start_date = Date.new(accounting_start_year, 4, 1)
    accounting_end_date = Date.new(accounting_end_year, 3, 31)    
    name = "#{accounting_start_year}-#{accounting_end_year}"
    acct_period = AccountingPeriod.new(:name => name, :start_date => accounting_start_date, :end_date => accounting_end_date)
    acct_period.branch_id = branch.id
    acct_period.save! if acct_period.valid?    
  end
    
  protected

  def open_accounting_period_as_unique_for_branch
    sql_condt = "and id != #{id}" unless new_record?
    open_accouting_period = AccountingPeriod.find(:first, :conditions => "state = 'Open' and branch_id = #{branch_id} #{sql_condt}")
    errors.add(:state, 'is already Open. You need to close an already open accounting period.') unless open_accouting_period.blank?
  end
  
  def overlapping_periods
    start_date_overlap = AccountingPeriod.find(:first, :conditions => "'#{start_date.to_s(:db)}' between start_date and last_current_day and branch_id = #{branch_id}")
    errors.add(:start_date, 'overlaps an existing period') unless start_date_overlap.blank?
    end_date_overlap = AccountingPeriod.find(:first, :conditions => "'#{end_date.to_s(:db)}' between start_date and last_current_day and branch_id = #{branch_id}")    
    errors.add(:last_current_day, 'overlaps an existing period') unless end_date_overlap.blank?
    errors.empty?
  end

  def set_branch_default_current_accounting_period
    self.closed_at = nil
    self.last_current_day = nil
    branch.update_attribute(:default_current_accounting_period_id, id)
  end

  def reset_branch_default_current_accounting_period
    self.closed_at = Time.zone.now
    branch.update_attribute(:default_current_accounting_period_id, nil)
  end

  def set_closing_balances
    accounting_period_account_balances.each do |accounting_period_account_balance|
      accounting_period_account_balance.closing_balance = accounting_period_account_balance.account.cumulative_current_balance
      accounting_period_account_balance.save!  

      accounting_period_account_balance.account.opening_balance = accounting_period_account_balance.account.cumulative_current_balance
      accounting_period_account_balance.account.current_balance = 0
      accounting_period_account_balance.account.save!
    end
  end

  def reset_closing_balances
    accounting_period_account_balances.each do |accounting_period_account_balance|
      accounting_period_account_balance.closing_balance = nil
      accounting_period_account_balance.save!

      accounting_period_account_balance.account.current_balance = accounting_period_account_balance.account.opening_balance - accounting_period_account_balance.opening_balance
      accounting_period_account_balance.account.opening_balance = accounting_period_account_balance.opening_balance
      accounting_period_account_balance.account.save!   
    end
  end

  def close_branch_current_day
    branch.default_current_open_day.close! unless branch.default_current_open_day.blank?
    self.last_current_day = branch.closed_accounting_days.last(:order => 'closed_at').for_date.to_datetime
  end

  def process_accounting_period_closure
    set_closing_balances
    close_branch_current_day
    reset_branch_default_current_accounting_period
  end

  def process_accounting_period_re_open
    set_branch_default_current_accounting_period
    reset_closing_balances
  end

  def create_new_accounting_period_account_balances
    last_closed_accounting_period = branch.closed_accounting_periods.last(:order => 'closed_at')
    return if last_closed_accounting_period.blank?
    last_closed_accounting_period.accounting_period_account_balances.each do |apb|
      accounting_period_account_balance = accounting_period_account_balances.build
      accounting_period_account_balance.account = apb.account
      accounting_period_account_balance.branch = branch
      accounting_period_account_balance.opening_balance = apb.closing_balance
      accounting_period_account_balance.save!
    end
  end
end
