company = Company.find_or_create_by_name('Santhathi')
branch = company.branches.find_or_create_by_name('Main')
if branch.accounting_days.blank?
  accounting_day = branch.accounting_days.build(:for_date => Date.today)
  accounting_day.save!
end

[BANK_AC, CASH_AC, PURCHASE_AC, MEDICINES_INCOME_AC, SERVICES_INCOME_AC, TESTS_INCOME_AC].each do |account|
  next if Account.exists?(:name => account[:name])
  account_group = AccountGroup.find_by_name_and_branch_id(account[:group], branch.id)  
  account = Account.new(:name => account[:name], :current_balance => 0)
  account.account_group_id = account_group.id
  account.branch_id = branch.id
  account.opening_balance = 0
  account.save! 
end

[STRIPS_UNIT, DOZENS_UNIT].each do |unit|
  inv_unit = InventoryUnitOfMeasurement.new(:unit_name => unit[:unit_name], :unit_symbol => unit[:unit_symbol], :sub_unit_name => unit[:sub_unit_name], :sub_unit_symbol => unit[:sub_unit_symbol], :unit_value => unit[:unit_value])
  inv_unit.branch_id = branch.id
  inv_unit.save
end

[MEDICINES_INV_GRP, LAB_EQUIPMENTS_INV_GRP].each do |grp|
  inv_grp = InventoryGroup.new(:name => grp[:name], :description => grp[:description])
  inv_grp.branch_id = branch.id
  inv_grp.save
end

#ConfigValue.find_or_create_by_name('DISABLE_AUTO_ACCOUNT_TRANSACTION')

Department.find_or_create_by_dept_name('Laboratory')
