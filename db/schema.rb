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

ActiveRecord::Schema.define(:version => 20131202072448) do

  create_table "books", :force => true do |t|
    t.integer  "price"
    t.text     "comment"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.text     "release_date"
    t.text     "location"
    t.integer  "sn",           :limit => 8
    t.text     "author"
    t.text     "sale_type"
    t.text     "name"
    t.text     "category"
    t.text     "publisher"
    t.integer  "order_id"
    t.text     "isbn"
  end

  create_table "branches", :force => true do |t|
    t.text     "name"
    t.text     "address"
    t.text     "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "carts", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "customers", :force => true do |t|
    t.text     "name"
    t.text     "email"
    t.text     "phone"
    t.text     "indoor_phone"
    t.text     "role"
    t.text     "expire_date"
    t.text     "address"
    t.text     "comment"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "line_items", :force => true do |t|
    t.integer  "book_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "order_id"
  end

  create_table "nd_multi_langs", :force => true do |t|
    t.text     "model"
    t.text     "version"
    t.text     "result_file"
    t.text     "user_id"
    t.text     "excel"
    t.text     "xml"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "sn"
    t.integer  "original_amount"
    t.integer  "actual_amount"
    t.text     "role"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "customer_id",     :limit => 8
    t.integer  "user_id"
    t.text     "upgrade"
  end

  create_table "role_records", :force => true do |t|
    t.integer  "customer_id"
    t.text     "role"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "expire_date"
    t.integer  "user_id"
    t.integer  "order_id"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "role"
    t.text     "phone"
    t.text     "indoor_phone"
    t.datetime "expire_date"
    t.text     "address"
    t.text     "name"
    t.integer  "branch_id"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
