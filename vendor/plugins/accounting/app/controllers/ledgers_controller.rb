class LedgersController < ApplicationController
  layout 'accounting'

  def show
    @account = user_default_branch.accounts.find(params[:id])
    @account_opening_balance = @account.opening_balance
    @account_transaction_items = user_default_branch.current_accounting_period.account_transaction_items.find(:all, 
                                                             :select => "account_transaction_items.account_id, case when account_transaction_items.parent_id = -1 then a2.amount else account_transaction_items.amount end as 'amount', account_transaction_items.category, account_transaction_items.account_id, account_transaction_items.account_transaction_id, a2.account_closing_balance, a2.category as 'acc_category'",
                                                             :joins => "account_transaction_items inner join account_transaction_items a2 on account_transaction_items.account_transaction_id = a2.account_transaction_id",
                                                             :include => [:account, :account_transaction],
                                                             :conditions => ["account_transaction_items.account_id != ? and a2.account_id = ? and account_transaction_items.parent_id != a2.parent_id", @account, @account],
                                                             :order => 'account_transaction_items.transaction_date')
  end
end
