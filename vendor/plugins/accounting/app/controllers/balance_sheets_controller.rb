class BalanceSheetsController < ApplicationController
  layout 'accounting'
  def show
    asset_group_type_id = user_default_branch.account_group_types.find_by_name('Assets').id
    @assets = user_default_branch.accounts.find(:all,
                                                                   :select => "accounts.name, (accounts.current_balance + accounts.opening_balance)as amount, accounts.id, accounts.account_group_id",
								   :joins => "inner join account_groups ag on accounts.account_group_id = ag.id",
                                                                   :conditions => "ag.account_group_type_id = #{asset_group_type_id}", :group => 'accounts.id', :order => 'accounts.id')

    liability_group_type_id = user_default_branch.account_group_types.find_by_name('Liabilities').id
    @liabilities = user_default_branch.accounts.find(:all,
                                                                  :select => "accounts.name, (accounts.current_balance + accounts.opening_balance) as amount, accounts.id, accounts.account_group_id",                            
  								  :joins => "inner join account_groups ag on accounts.account_group_id = ag.id",                                    
                                                                  :conditions => "ag.account_group_type_id = #{liability_group_type_id}", :group => 'accounts.id', :order => 'accounts.id')    
  end
end
