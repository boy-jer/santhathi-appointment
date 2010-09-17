class AccountGroup < ActiveRecord::Base
  acts_as_tree
  
  has_many :account_sub_groups
  has_many :accounts
  belongs_to :account_group_type
  belongs_to :branch
  
  validates_presence_of :name, :branch_id, :account_group_type_id
  validates_uniqueness_of :name, :scope => :branch_id  
  
  attr_accessible :name, :description, :is_p_and_l_acct
  
  def under_group_type
    if self[:type] == 'AccountMainGroup' 
      return account_group_type.name
    elsif self[:type] == 'AccountSubGroup' 
      return account_main_group.account_group_type.name    
    end
  end

  def self.cash_opening_balance(branch_id, for_date=Date.today)
    cash_sub_group_id = AccountSubGroup.find_by_name_and_branch_id('Cash-in Hand', branch_id).id
    cash_account_ids = Account.find_all_by_account_group_id(cash_sub_group_id).map{|m| m.id}.join(',')
    AccountBalance.sum(:opening_balance, :conditions => "account_id in (#{cash_account_ids}) and for_date = '#{for_date.to_s(:db)}'")
  end

end
