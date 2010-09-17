#
COMPANY_NAME = 'Kaiga Thrift Society'
BRANCH_NAME = 'Main'

#Asset accounts
BANK_AC = {:name => 'State Bank of India S.B. A/c.', :group => 'Bank Accounts'}
CASH_AC = {:name => 'Cash A/c.', :group => 'Cash-in Hand'}

#Liabitiies accounts


#Expenses accounts
PURCHASE_AC = {:name => 'Purchases A/c.', :group => 'Purchases Account'}

#Income accounts
MEDICINES_INCOME_AC = {:name => 'Medicines Income A/c.', :group => 'Direct Income'}
SERVICES_INCOME_AC = {:name => 'Services Incone A/c.', :group => 'Direct Income'}
TESTS_INCOME_AC = {:name => 'Tests Incone A/c.', :group => 'Direct Income'}

##Inventory
#Unit of measurements
STRIPS_UNIT = {:unit_name => 'Strip', :unit_symbol => 'strips', :sub_unit_name => 'Pieces', :sub_unit_symbol => 'pcs', :unit_value => 10}
DOZENS_UNIT = {:unit_name => 'Dozen', :unit_symbol => 'dozen', :sub_unit_name => 'Pieces', :sub_unit_symbol => 'pcs', :unit_value => 12}

#Inventory Groups
MEDICINES_INV_GRP = {:name => 'Medicines', :description => 'Medicines'}
LAB_EQUIPMENTS_INV_GRP = {:name => 'Laboratory Items', :description => 'Medicines'}
