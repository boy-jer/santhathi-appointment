# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def current_accounting_period
    user_default_branch.current_accounting_period.name    
  end
  
  def account_group_type_options_array
    user_default_branch.account_group_types.all.map{|m| [m.name, m.id]}
  end
  
  def account_main_group_options_array
    user_default_branch.account_main_groups.all.map{|m| [m.name, m.id]}
  end  
    
  def account_options_array
    @account_options_array = @account_options_array || user_default_branch.accounts.all.map{|m| [m.name, m.id]}.unshift(['',''])
  end

  def setup_particulars(account_transaction)
    returning(account_transaction) do |at|
      at.account_transaction_items.build([{},{},{},{},{},{},{},{},{},{}]) if at.account_transaction_items.blank?
    end
  end
end
