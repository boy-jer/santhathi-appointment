class BalanceSheetsController < ApplicationController
  layout 'accounting'
  def show
    account_details  
  end
  def grouped
    account_details  
  end
  
  
  def account_details  
    @current_accounting_period = user_default_branch.current_accounting_period
    asset_group_type_id = user_default_branch.account_group_types.find_by_name('Assets').id                                                              
    liability_group_type_id = user_default_branch.account_group_types.find_by_name('Liabilities').id                                                              
    expense_group_type_id = user_default_branch.account_group_types.find_by_name('Expense').id
    income_group_type_id = user_default_branch.account_group_types.find_by_name('Income').id
        
    @assets = user_default_branch.accounts.find(:all,:select => "accounts.name, (accounts.current_balance + accounts.opening_balance)as amount, accounts.id, accounts.account_group_id", :joins => "inner join account_groups ag on accounts.account_group_id = ag.id",  :conditions => "ag.account_group_type_id = #{asset_group_type_id}", :group => 'accounts.id', :order => 'accounts.id')
    
    @liabilities = user_default_branch.accounts.find(:all,:select => "accounts.name, (accounts.current_balance + accounts.opening_balance) as amount, accounts.id, accounts.account_group_id", :joins => "inner join account_groups ag on accounts.account_group_id = ag.id",  :conditions => "ag.account_group_type_id = #{liability_group_type_id}", :group => 'accounts.id', :order => 'accounts.id')    
    
    @expenses = user_default_branch.accounts.find(:all,:select => "sum(accounts.current_balance + accounts.opening_balance) as amount",:joins => "inner join account_groups ag on accounts.account_group_id = ag.id", :conditions => "ag.account_group_type_id = #{expense_group_type_id}")
                                                                   
   
    
    @incomes = user_default_branch.accounts.find(:all, :select => "sum(accounts.current_balance + accounts.opening_balance) as amount", :joins => "inner join account_groups ag on accounts.account_group_id = ag.id", :conditions => "ag.account_group_type_id = #{income_group_type_id}")                                                           
  end
  
    
end
