# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121122144240) do

  create_table "attendees", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "type",       :null => false
  end

  add_index "attendees", ["event_id"], :name => "index_attendees_on_event_id"
  add_index "attendees", ["user_id"], :name => "index_attendees_on_user_id"

  create_table "bids", :force => true do |t|
    t.string   "first_name",                           :null => false
    t.string   "last_name",                            :null => false
    t.string   "third_name"
    t.string   "address",                              :null => false
    t.string   "policy",                               :null => false
    t.string   "passport_scan",                        :null => false
    t.string   "status",        :default => "created", :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "email",                                :null => false
  end

  create_table "documents", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.string   "record"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "documents", ["event_id"], :name => "index_documents_on_event_id"
  add_index "documents", ["user_id"], :name => "index_documents_on_user_id"

  create_table "events", :force => true do |t|
    t.integer  "user_id"
    t.datetime "date_start",                      :null => false
    t.string   "description"
    t.string   "status",      :default => "free", :null => false
    t.string   "summary",                         :null => false
    t.datetime "date_end"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "category"
    t.string   "type",                            :null => false
    t.integer  "duration"
    t.integer  "event_id"
  end

  add_index "events", ["user_id"], :name => "index_events_on_user_id"

  create_table "parameters", :force => true do |t|
    t.string   "name",                    :null => false
    t.string   "type",                    :null => false
    t.text     "metadata",                :null => false
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "rule_parameter_input_id"
  end

  create_table "parameters_data", :force => true do |t|
    t.integer  "user_id"
    t.integer  "parameter_id"
    t.string   "value"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "parameters_storages", :force => true do |t|
    t.integer  "parameter_id"
    t.integer  "user_id"
    t.string   "value"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "parameters_storages", ["parameter_id"], :name => "index_parameters_storages_on_parameter_id"
  add_index "parameters_storages", ["user_id"], :name => "index_parameters_storages_on_user_id"

  create_table "parameters_to_patients", :force => true do |t|
    t.integer  "user_id"
    t.integer  "parameter_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "recurrence_rules", :force => true do |t|
    t.integer  "event_id"
    t.string   "frequency",                 :null => false
    t.integer  "count"
    t.datetime "end_date"
    t.integer  "interval"
    t.string   "seconds"
    t.string   "minutes"
    t.string   "hours"
    t.string   "week_days"
    t.string   "month_days"
    t.string   "year_days"
    t.string   "weeks"
    t.string   "months"
    t.string   "position"
    t.integer  "fact_count"
    t.boolean  "active"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "week_start", :default => 1, :null => false
  end

  add_index "recurrence_rules", ["event_id"], :name => "index_recurrence_rules_on_event_id"

  create_table "roles", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rule_parameter_inputs", :force => true do |t|
    t.string   "rule"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "type",                                      :null => false
    t.string   "first_name",                                :null => false
    t.string   "last_name",                                 :null => false
    t.string   "third_name"
    t.string   "address",                                   :null => false
    t.string   "policy"
    t.integer  "doctor_user_id"
    t.boolean  "timeout_block",          :default => false, :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_to_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "users_to_roles", ["role_id"], :name => "index_users_to_roles_on_role_id"
  add_index "users_to_roles", ["user_id"], :name => "index_users_to_roles_on_user_id"

  add_foreign_key "attendees", "events", :name => "attendees_event_id_fk"
  add_foreign_key "attendees", "users", :name => "attendees_user_id_fk"

  add_foreign_key "documents", "events", :name => "documents_event_id_fk"
  add_foreign_key "documents", "users", :name => "documents_user_id_fk"

  add_foreign_key "events", "events", :name => "events_event_id_fk"
  add_foreign_key "events", "users", :name => "events_user_id_fk"

  add_foreign_key "parameters", "rule_parameter_inputs", :name => "parameters_rule_parameter_input_id_fk"

  add_foreign_key "parameters_data", "parameters", :name => "parameters_data_parameter_id_fk"
  add_foreign_key "parameters_data", "users", :name => "parameters_data_user_id_fk"

  add_foreign_key "parameters_storages", "parameters", :name => "parameters_storages_parameter_id_fk"
  add_foreign_key "parameters_storages", "users", :name => "parameters_storages_user_id_fk"

  add_foreign_key "parameters_to_patients", "parameters", :name => "parameters_to_patients_parameter_id_fk"
  add_foreign_key "parameters_to_patients", "users", :name => "parameters_to_patients_user_id_fk"

  add_foreign_key "recurrence_rules", "events", :name => "recurrence_rules_event_id_fk"

  add_foreign_key "users", "users", :name => "users_doctor_user_id_fk", :column => "doctor_user_id"

  add_foreign_key "users_to_roles", "roles", :name => "users_to_roles_role_id_fk"
  add_foreign_key "users_to_roles", "users", :name => "users_to_roles_user_id_fk"

end
