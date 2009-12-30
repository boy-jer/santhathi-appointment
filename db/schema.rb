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

ActiveRecord::Schema.define(:version => 20091229090553) do

  create_table "account_balances", :force => true do |t|
    t.integer  "account_id"
    t.integer  "accounting_period_id"
    t.integer  "accounting_day_id"
    t.decimal  "opening_balance",      :precision => 11, :scale => 2
    t.decimal  "closing_balance",      :precision => 11, :scale => 2
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
    t.integer  "accounting_period_id"
    t.integer  "accounting_day_id"
    t.integer  "account_transaction_id"
    t.integer  "account_id"
    t.string   "category"
    t.decimal  "amount",                               :precision => 11, :scale => 2
    t.integer  "parent_id"
    t.decimal  "account_opening_balance",              :precision => 11, :scale => 2
    t.decimal  "account_closing_balance",              :precision => 11, :scale => 2
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
    t.string   "narrations",                   :limit => 5000
    t.integer  "accounting_period_id"
    t.integer  "accounting_day_id"
    t.integer  "branch_id"
    t.string   "type"
    t.string   "account_transactionable_on"
    t.string   "account_transactionable_type"
    t.integer  "account_transactionable_id"
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
    t.date     "closed_at"
    t.boolean  "is_transacted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "accounting_period_account_balances", :force => true do |t|
    t.integer  "account_id"
    t.integer  "accounting_period_id"
    t.integer  "branch_id"
    t.decimal  "opening_balance",      :precision => 11, :scale => 2
    t.decimal  "closing_balance",      :precision => 11, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "accounting_period_inventory_stocks", :force => true do |t|
    t.integer  "inventory_item_id"
    t.integer  "accounting_period_id"
    t.integer  "branch_id"
    t.integer  "opening_stock"
    t.integer  "closing_stock"
    t.decimal  "opening_stock_value",  :precision => 8, :scale => 2
    t.decimal  "closing_stock_value",  :precision => 8, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "accounting_periods", :force => true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "state"
    t.integer  "branch_id"
    t.datetime "closed_at"
    t.datetime "last_current_day"
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
    t.decimal  "current_balance",  :precision => 11, :scale => 2, :default => 0.0
    t.decimal  "opening_balance",  :precision => 11, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["account_group_id"], :name => "index_accounts_on_account_group_id"
  add_index "accounts", ["branch_id"], :name => "index_accounts_on_branch_id"

  create_table "appointments", :force => true do |t|
    t.integer  "department_id"
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.integer  "reason_id"
    t.date     "appointment_date"
    t.time     "appointment_time"
    t.string   "state"
    t.integer  "mode_id"
    t.string   "visit_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
  end

  create_table "branches", :force => true do |t|
    t.string   "name"
    t.integer  "company_id"
    t.integer  "default_current_open_day_id"
    t.integer  "default_current_accounting_period_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "branches", ["company_id"], :name => "index_branches_on_company_id"

  create_table "clinical_comments", :force => true do |t|
    t.text     "commet"
    t.integer  "appointment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cms", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deactivate_slots", :force => true do |t|
    t.integer  "doctor_id"
    t.date     "from_date"
    t.time     "time_from"
    t.string   "reason_for_absence"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slots"
  end

  create_table "departments", :force => true do |t|
    t.string   "dept_name"
    t.string   "description"
    t.string   "system_defined"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discharge_summaries", :force => true do |t|
    t.date     "preparation"
    t.text     "complaints"
    t.text     "symptoms"
    t.text     "treatment"
    t.text     "treatment_result"
    t.text     "remarks"
    t.integer  "appointment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "disease_lists", :force => true do |t|
    t.string   "disease"
    t.string   "icd_code"
    t.string   "family_history"
    t.string   "immunization"
    t.string   "med_history"
    t.string   "gyno_history"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doctor_profiles", :force => true do |t|
    t.integer  "department_id"
    t.integer  "doctor_id"
    t.string   "name"
    t.string   "designation"
    t.string   "medical_id"
    t.time     "working_from"
    t.time     "working_to"
    t.string   "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doctor_working_slots", :force => true do |t|
    t.integer  "doctor_id"
    t.time     "start_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slots"
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
    t.decimal  "unit_buy_price",                   :precision => 11, :scale => 2
    t.decimal  "unit_sale_price",                  :precision => 11, :scale => 2
    t.decimal  "sub_unit_sale_price",              :precision => 11, :scale => 2
    t.integer  "inventory_group_id"
    t.boolean  "consumable"
    t.boolean  "discount_allowed"
    t.integer  "inventory_unit_of_measurement_id"
    t.integer  "current_quantity",                                                :default => 0
    t.integer  "opening_quantity"
    t.string   "shelf_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inventory_items", ["branch_id"], :name => "index_inventory_items_on_branch_id"
  add_index "inventory_items", ["inventory_group_id"], :name => "index_inventory_items_on_inventory_group_id"

  create_table "inventory_stocks", :force => true do |t|
    t.integer  "inventory_item_id"
    t.integer  "accounting_period_id"
    t.integer  "accounting_day_id"
    t.integer  "branch_id"
    t.integer  "opening_stock"
    t.integer  "closing_stock"
    t.decimal  "opening_stock_value",  :precision => 8, :scale => 2
    t.decimal  "closing_stock_value",  :precision => 8, :scale => 2
    t.date     "for_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventory_transaction_items", :force => true do |t|
    t.integer  "inventory_item_id"
    t.integer  "inventory_transaction_id"
    t.string   "unit_type"
    t.integer  "quantity"
    t.integer  "price",                                   :limit => 10, :precision => 10, :scale => 0
    t.decimal  "total_price",                                           :precision => 11, :scale => 2
    t.integer  "inventory_opening_stock_quantity",        :limit => 10, :precision => 10, :scale => 0
    t.integer  "inventory_closing_stock_quantity",        :limit => 10, :precision => 10, :scale => 0
    t.integer  "current_quantity"
    t.decimal  "inventory_item_buy_price",                              :precision => 11, :scale => 2
    t.integer  "purchased_inventory_transaction_item_id"
    t.decimal  "total_vat_price",                                       :precision => 11, :scale => 2
    t.decimal  "total_item_price",                                      :precision => 11, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventory_transactions", :force => true do |t|
    t.integer  "branch_id"
    t.integer  "accounting_day_id"
    t.integer  "accounting_period_id"
    t.integer  "account_transaction_id"
    t.string   "category"
    t.string   "narration",              :limit => 1000
    t.date     "transaction_date"
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

  create_table "lab_tests", :force => true do |t|
    t.string   "name"
    t.time     "duration"
    t.string   "pre_requisites"
    t.integer  "parent_id"
    t.integer  "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "laboratory_reports", :force => true do |t|
    t.integer  "appointment_id"
    t.integer  "prescription_id"
    t.integer  "lab_test_id"
    t.date     "date_of_action"
    t.time     "time_of_action"
    t.integer  "action_taken_by_id"
    t.integer  "authorised_by_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "laboratory_test_results", :force => true do |t|
    t.string   "result"
    t.string   "remarks"
    t.integer  "laboratory_report_id"
    t.integer  "parameter_specification_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "measurement_units", :force => true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.text     "message_body"
    t.integer  "user_id"
    t.string   "number"
    t.string   "status"
    t.integer  "sms_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "next_appointment_remarks", :force => true do |t|
    t.string   "remarks"
    t.integer  "appointment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :null => false
    t.string  "server_url"
    t.string  "salt",       :null => false
  end

  create_table "parameter_specifications", :force => true do |t|
    t.integer  "lab_test_id"
    t.integer  "parameter_id"
    t.integer  "age_group_from"
    t.integer  "age_group_to"
    t.string   "gender"
    t.string   "ideal_value"
    t.string   "min_value"
    t.string   "max_value"
    t.string   "special_condition"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parameter_values", :force => true do |t|
    t.integer  "parameter_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parameters", :force => true do |t|
    t.string   "parameter_name"
    t.string   "value_type"
    t.string   "description"
    t.integer  "measurement_unit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patients", :force => true do |t|
    t.date     "reg_date"
    t.string   "patient_name"
    t.string   "reg_no"
    t.date     "dob"
    t.string   "gender"
    t.string   "spouse_name"
    t.integer  "spouse"
    t.string   "email"
    t.text     "address"
    t.string   "contact_no"
    t.string   "reg_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pharamacy_item_information_details", :force => true do |t|
    t.integer  "quantity"
    t.integer  "course_duration"
    t.text     "other_remarks"
    t.integer  "pharamacy_item_information_id"
    t.integer  "pharmacy_course_list_id"
    t.integer  "pharmacy_dosage_list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pharamacy_item_informations", :force => true do |t|
    t.string   "item_name"
    t.string   "item_code"
    t.string   "uom"
    t.string   "category_name"
    t.string   "user_sku"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pharmacy_course_lists", :force => true do |t|
    t.string   "course_type_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pharmacy_dosage_lists", :force => true do |t|
    t.string   "dosage_type_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pharmacy_prescriptions", :force => true do |t|
    t.date     "prescribing_date"
    t.integer  "course_duration"
    t.text     "other_remarks"
    t.integer  "quantity"
    t.date     "course_start_date"
    t.time     "time_of_prescription"
    t.date     "course_end_date"
    t.integer  "appointment_id"
    t.integer  "pharamacy_item_information_id"
    t.integer  "pharmacy_course_list_id"
    t.integer  "pharmacy_dosage_list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pms", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prescribed_tests", :force => true do |t|
    t.integer  "prescription_id"
    t.integer  "lab_test_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prescriptions", :force => true do |t|
    t.date     "p_date"
    t.time     "p_time"
    t.integer  "quantity"
    t.string   "urgency"
    t.date     "follow_up"
    t.string   "remarks"
    t.integer  "department_id"
    t.integer  "appointment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "real_name"
    t.string   "location"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reasons", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "refer_doctors", :force => true do |t|
    t.date     "reference_date"
    t.text     "remarks"
    t.integer  "doctor_id"
    t.integer  "appointment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registration_summaries", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "sample_specfications", :force => true do |t|
    t.integer  "age_group_from"
    t.integer  "age_group_to"
    t.integer  "sample_id"
    t.string   "volume"
    t.string   "min_volume"
    t.string   "sample_for"
    t.string   "collection_proedure"
    t.string   "specimen_condition"
    t.string   "container_type"
    t.string   "storage_instructions"
    t.integer  "lab_test_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "samples", :force => true do |t|
    t.string   "sample_name"
    t.string   "description"
    t.string   "used_in_diagnosis_of"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "select_options", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.integer  "position"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "cost"
    t.string   "first_visit"
    t.string   "follow_up_visit"
    t.integer  "department_id"
    t.integer  "parent_id"
    t.integer  "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", :force => true do |t|
    t.string   "label"
    t.string   "identifier"
    t.text     "description"
    t.string   "field_type",  :default => "string"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "test_parameters", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "identity_url"
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token",            :limit => 40
    t.string   "activation_code",           :limit => 40
    t.string   "state",                                    :default => "passive"
    t.datetime "remember_token_expires_at"
    t.string   "password_reset_code"
    t.string   "type"
    t.datetime "activated_at"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "vital_signs", :force => true do |t|
    t.integer  "patient_id"
    t.integer  "registration_summary_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
