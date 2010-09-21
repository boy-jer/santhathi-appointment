class ProfitAndLossStatementsController < ApplicationController
  layout 'accounting'

  def show
    expense_group_type_id = user_default_branch.account_group_types.find_by_name('Expense').id
    @expenses = user_default_branch.accounts.find(:all,
                                                                   :select => "accounts.name, (accounts.current_balance + accounts.opening_balance) as amount, accounts.id, accounts.account_group_id",
								   :joins => "inner join account_groups ag on accounts.account_group_id = ag.id",
                                                                   :conditions => "ag.account_group_type_id = #{expense_group_type_id}", :group => 'accounts.id', :order => 'accounts.id')

    income_group_type_id = user_default_branch.account_group_types.find_by_name('Income').id
    @incomes = user_default_branch.accounts.find(:all,
                                                                  :select => "accounts.name, (accounts.current_balance + accounts.opening_balance) as amount, accounts.id, accounts.account_group_id",                            
  								  :joins => "inner join account_groups ag on accounts.account_group_id = ag.id",                                    
                                                                  :conditions => "ag.account_group_type_id = #{income_group_type_id}", :group => 'accounts.id', :order => 'accounts.id')

=begin
    @expenses = user_default_branch.account_transaction_items.find(:all,
                                                                   :select => "a.name, SUM(case when account_transaction_items.category = 'Debit' then account_transaction_items.amount else 0 end) - SUM(case when account_transaction_items.category = 'Credit' then account_transaction_items.amount else 0 end) as amount, account_transaction_items.account_id", 
                                                                   :joins => "inner join accounts as a on account_transaction_items.account_id = a.id inner join account_groups ag on a.account_group_id = ag.id",
                                                                   :conditions => "ag.account_group_type_id = #{expense_group_type_id}", :group => 'account_transaction_items.account_id', :order => 'account_transaction_items.account_id')

    income_group_type_id = user_default_branch.account_group_types.find_by_name('Income').id
    @incomes = user_default_branch.account_transaction_items.find(:all,
                                                                  :select => "a.name, SUM(case when account_transaction_items.category = 'Credit' then account_transaction_items.amount else 0 end) - SUM(case when account_transaction_items.category = 'Debit' then account_transaction_items.amount else 0 end) as amount, account_transaction_items.account_id",
                                                                   :joins => "inner join accounts as a on account_transaction_items.account_id = a.id inner join account_groups ag on a.account_group_id = ag.id",
                                                                   :conditions => "ag.account_group_type_id = #{income_group_type_id}", :group => 'account_transaction_items.account_id', :order => 'account_transaction_items.account_id')
=end
  end

end
