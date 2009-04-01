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

ActiveRecord::Schema.define(:version => 20090330072323) do

  create_table "appointments", :force => true do |t|
    t.integer  "doctor_id"
    t.integer  "reason_id"
    t.integer  "patient_id"
    t.date     "appointment_date"
    t.time     "appointment_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
  end

  create_table "cms", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deactivate_slots", :force => true do |t|
    t.string   "department"
    t.string   "doctor_name"
    t.date     "from_date"
    t.date     "to_date"
    t.time     "time_from"
    t.time     "time_to"
    t.string   "reason_for_absence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", :force => true do |t|
    t.string   "dept_name"
    t.string   "abbrevation"
    t.string   "description"
    t.string   "system_defined"
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

  create_table "doctor_appointments", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doctors", :force => true do |t|
    t.integer  "department_id"
    t.string   "name"
    t.string   "designation"
    t.string   "medical_id"
    t.time     "working_from"
    t.time     "working_to"
    t.string   "comments"
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

  create_table "parameters", :force => true do |t|
    t.string   "parameter_name"
    t.string   "value_type"
    t.string   "description"
    t.integer  "measurement_unit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patients", :force => true do |t|
    t.string   "hospital_no"
    t.string   "reg_no"
    t.string   "reg_type"
    t.string   "gender"
    t.date     "reg_date"
    t.string   "patient_name"
    t.string   "age"
    t.date     "dob"
    t.string   "spouse_name"
    t.string   "address"
    t.string   "contact_no"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "spouse"
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

  create_table "pms", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prescribed_tests", :force => true do |t|
    t.integer "prescription_id"
    t.integer "service_id"
    t.string  "result"
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

  create_table "prescriptions_services", :force => true do |t|
    t.integer "prescription_id"
    t.integer "service_id"
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

  create_table "registration_summaries", :force => true do |t|
    t.string   "registration_summary"
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
    t.string   "abbrevation"
    t.integer  "position"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", :force => true do |t|
    t.string   "service_name"
    t.string   "description"
    t.string   "cost"
    t.string   "first_visit"
    t.string   "follow_up_visit"
    t.integer  "department_id"
    t.boolean  "final_level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "depth"
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

  create_table "test_results", :force => true do |t|
    t.integer "prescription_id"
    t.integer "service_id"
    t.string  "result"
  end

  create_table "time_slots", :force => true do |t|
    t.datetime "schedule_date"
    t.time     "start_time"
    t.integer  "doctor_id"
    t.integer  "patient_id"
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
    t.string   "password_reset_cod"
    t.datetime "activated_at"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
