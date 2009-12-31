class AccountingDay < ActiveRecord::Base
  include AASM
  belongs_to :branch
  belongs_to :accounting_period
  has_many :account_balances

  has_many :inventory_transaction_items

  attr_accessible :for_date

  aasm_column :state
  aasm_initial_state :Open
  aasm_state :Open
  aasm_state :Closed
  
  aasm_event :close do
    transitions :to => :Closed, :from => [:Open], :on_transition => :reset_branch_default_current_open_day
  end

  aasm_event :re_open do
    transitions :to => :Open, :from => [:Closed], :on_transition => :set_branch_default_current_open_day
  end

  validates_presence_of :branch_id, :accounting_period_id, :for_date
  validates_uniqueness_of :for_date, :scope => :branch_id
  validate :for_date_range
  validate :open_accounting_day_as_unique_for_branch

  before_validation :set_accounting_period_column
  after_create :set_branch_default_current_open_day, :create_account_balances

  protected

  def open_accounting_day_as_unique_for_branch
    sql_condt = "and id != #{id}" unless new_record?
    open_accouting_day = AccountingDay.find(:first, :conditions => "state = 'Open' and branch_id = #{branch_id} #{sql_condt}")
    errors.add(:state, 'is already Open. You need to close an already open day.') unless open_accouting_day.blank?
  end

  def set_accounting_period_column
    accounting_period = branch.current_accounting_period
    write_attribute(:accounting_period_id, accounting_period.id)
  end

  def for_date_range
    sql_condt = "id != #{id}" unless new_record?
    last_accounting_day = branch.accounting_days.first(:order => 'for_date DESC', :conditions => sql_condt)
    return if last_accounting_day.blank?
    errors.add(:for_date, "should be between #{last_accounting_day.for_date} and #{Date.today}") if (for_date < last_accounting_day.for_date or for_date > Date.today)
  end

  def create_account_balances
    last_accounting_day = branch.accounting_days.first(:order => 'for_date DESC', :conditions => "id != #{id}")
    return if last_accounting_day.blank?
    last_accounting_day.account_balances.each do |account_balance|
      new_ab = branch.account_balances.build
      new_ab.account_id =  account_balance.account_id
      new_ab.accounting_period_id = branch.current_accounting_period.id
      new_ab.accounting_day_id = id
      new_ab.opening_balance = account_balance.closing_balance
      new_ab.closing_balance = account_balance.closing_balance
      new_ab.for_date = for_date
      new_ab.save!
    end
  end

  def set_branch_default_current_open_day
    self.closed_at = nil
    branch.update_attribute(:default_current_open_day_id, id)
  end

  def reset_branch_default_current_open_day
    self.closed_at = Time.zone.now
    branch.update_attribute(:default_current_open_day_id, nil)
  end
end
