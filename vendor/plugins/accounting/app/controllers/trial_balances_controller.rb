class TrialBalancesController < ApplicationController
  layout 'accounting'

  def show
    @trial_balance_array = []
    credit_sum_arr = user_default_branch.current_accounting_period.account_transaction_items.find(:all,
                                                                 :select => "account_id, SUM(amount) as amount_sum",
                                                                 :conditions => "category = 'Credit'",
                                                                 :group => 'account_id').map{|m| [m.account_id, m.amount_sum.to_f]}
    debit_sum_arr = user_default_branch.current_accounting_period.account_transaction_items.find(:all,
                                                               :select => "account_id, SUM(amount) as amount_sum",
                                                               :conditions => "category = 'Debit'",
                                                               :group => 'account_id').map{|m| [m.account_id, m.amount_sum.to_f]}
    accounts = user_default_branch.accounts
    accounts.each do |account|                        
      credit_sum = credit_sum_arr.assoc(account.id).blank? ? 0 : credit_sum_arr.assoc(account.id)[1]
      debit_sum = debit_sum_arr.assoc(account.id).blank? ? 0 : debit_sum_arr.assoc(account.id)[1]
      next if credit_sum == debit_sum
      difference = credit_sum > debit_sum ? credit_sum - debit_sum : debit_sum - credit_sum
      type = credit_sum > debit_sum ? "Credit" : "Debit"
      @trial_balance_array << {"account_name" => account.name, "amount" => difference, "type" => type, "account_id" => account.id}            
    end
  end
end
