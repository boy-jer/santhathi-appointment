company = Company.find_or_create_by_name('Santhathi')
branch = company.branches.find_or_create_by_name('Main')
if branch.accounting_days.blank?
  accounting_day = branch.accounting_days.build(:for_date => Date.today)
  accounting_day.save!
end

[BANK_AC, CASH_AC].each do |account|
  next if Account.exists?(:name => account[:name])
  account_group = AccountGroup.find_by_name_and_branch_id(account[:group], branch.id)  
  account = Account.new(:name => account[:name], :current_balance => 0)
  account.account_group_id = account_group.id
  account.branch_id = branch.id
  account.opening_balance = 0
  account.save! 
end

#ConfigValue.find_or_create_by_name('DISABLE_AUTO_ACCOUNT_TRANSACTION')
