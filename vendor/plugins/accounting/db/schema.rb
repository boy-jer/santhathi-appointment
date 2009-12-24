# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090625125330) do

  create_table "account_balances", :force => true do |t|
    t.integer  "account_id"
    t.integer  "accounting_period_id"
    t.integer  "accounting_day_id"
    t.decimal  "opening_balance",      :precision => 8, :scale => 2
    t.decimal  "closing_balance",      :precision => 8, :scale => 2
    t.date     "for_date"
    t.integer  "branch_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "account_balances", ["account_id"], :name => "index_account_balances_on_account_id"
  add_index "account_balances", ["accounting_period_id"], :name => "index_account_balances_on_accounting_period_id"
  add_index "account_balances", ["branch_id"], :name => "index_account_balances_on_branch_id"

  create_table "account_group_types", :force => true do |t|
    t.string   "name"
    t.string   "description", :limit => 1000
    t.integer  "branch_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "account_group_types", ["branch_id"], :name => "index_account_group_types_on_branch_id"

  create_table "account_groups", :force => true do |t|
    t.string   "name"
    t.string   "description",           :limit => 1000
    t.string   "type"
    t.integer  "parent_id"
    t.boolean  "is_p_and_l_acct"
    t.integer  "account_group_type_id"
    t.integer  "branch_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "account_groups", ["account_group_type_id"], :name => "index_account_groups_on_account_group_type_id"
  add_index "account_groups", ["branch_id"], :name => "index_account_groups_on_branch_id"
  add_index "account_groups", ["parent_id"], :name => "index_account_groups_on_parent_id"

  create_table "account_transaction_items", :force => true do |t|
    t.integer  "account_transaction_id"
    t.integer  "account_id"
    t.string   "category"
    t.decimal  "amount",                               :precision => 8, :scale => 2
    t.integer  "parent_id"
    t.decimal  "account_opening_balance",              :precision => 8, :scale => 2
    t.decimal  "account_closing_balance",              :precision => 8, :scale => 2
    t.date     "transaction_date"
    t.string   "transaction_type",        :limit => 1
    t.integer  "branch_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "account_transaction_items", ["account_id"], :name => "index_account_transaction_items_on_account_id"
  add_index "account_transaction_items", ["account_transaction_id"], :name => "index_account_transaction_items_on_account_transaction_id"
  add_index "account_transaction_items", ["branch_id"], :name => "index_account_transaction_items_on_branch_id"
  add_index "account_transaction_items", ["category"], :name => "index_account_transaction_items_on_category"
  add_index "account_transaction_items", ["parent_id"], :name => "index_account_transaction_items_on_parent_id"
  add_index "account_transaction_items", ["transaction_date"], :name => "index_account_transaction_items_on_transaction_date"
  add_index "account_transaction_items", ["transaction_type"], :name => "index_account_transaction_items_on_transaction_type"

  create_table "account_transactions", :force => true do |t|
    t.string   "transaction_no"
    t.date     "transaction_date"
    t.string   "narrations",           :limit => 5000
    t.integer  "accounting_period_id"
    t.integer  "branch_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "account_transactions", ["accounting_period_id"], :name => "index_account_transactions_on_accounting_period_id"
  add_index "account_transactions", ["branch_id"], :name => "index_account_transactions_on_branch_id"

  create_table "accounting_days", :force => true do |t|
    t.integer  "branch_id"
    t.integer  "accounting_period_id"
    t.date     "for_date"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "accounting_periods", :force => true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "state"
    t.integer  "branch_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounting_periods", ["branch_id"], :name => "index_accounting_periods_on_branch_id"
  add_index "accounting_periods", ["end_date"], :name => "index_accounting_periods_on_end_date"
  add_index "accounting_periods", ["start_date"], :name => "index_accounting_periods_on_start_date"

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.integer  "account_group_id"
    t.integer  "branch_id"
    t.decimal  "current_balance",  :precision => 8, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["account_group_id"], :name => "index_accounts_on_account_group_id"
  add_index "accounts", ["branch_id"], :name => "index_accounts_on_branch_id"

  create_table "branches", :force => true do |t|
    t.string   "name"
    t.integer  "company_id"
    t.integer  "default_current_open_day_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "branches", ["company_id"], :name => "index_branches_on_company_id"

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventory_groups", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "branch_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventory_items", :force => true do |t|
    t.integer  "branch_id"
    t.string   "name"
    t.integer  "lot_size"
    t.decimal  "buy_price",                        :precision => 8, :scale => 2
    t.decimal  "sale_price",                       :precision => 8, :scale => 2
    t.integer  "inventory_group_id"
    t.boolean  "consumable"
    t.boolean  "discount_allowed"
    t.integer  "inventory_unit_of_measurement_id"
    t.integer  "current_quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inventory_items", ["branch_id"], :name => "index_inventory_items_on_branch_id"
  add_index "inventory_items", ["inventory_group_id"], :name => "index_inventory_items_on_inventory_group_id"

  create_table "inventory_transactions", :force => true do |t|
    t.integer  "branch_id"
    t.integer  "inventory_item_id"
    t.string   "transaction_type"
    t.integer  "account_id"
    t.date     "transaction_date"
    t.integer  "quantity"
    t.integer  "cost",              :limit => 10, :precision => 10, :scale => 0
    t.decimal  "total_cost",                      :precision => 8,  :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventory_unit_of_measurements", :force => true do |t|
    t.integer  "branch_id"
    t.string   "unit_name"
    t.string   "unit_symbol"
    t.string   "sub_unit_name"
    t.string   "sub_unit_symbol"
    t.integer  "unit_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "login",                              :null => false
    t.string   "email",                              :null => false
    t.integer  "company_id"
    t.integer  "branch_id"
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["branch_id"], :name => "index_users_on_branch_id"
  add_index "users", ["company_id"], :name => "index_users_on_company_id"

end
