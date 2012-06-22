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

ActiveRecord::Schema.define(:version => 20120622165728) do

  create_table "companies", :force => true do |t|
    t.string   "corporate_name"
    t.string   "address"
    t.integer  "zip_code"
    t.string   "city"
    t.string   "phone_number"
    t.string   "contact_first_name"
    t.string   "contact_last_name"
    t.string   "contact_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contracts", :force => true do |t|
    t.integer  "student_id"
    t.integer  "company_id"
    t.integer  "recruiter_id"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "klasses", :force => true do |t|
    t.integer  "training_id"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "klasses_students", :id => false, :force => true do |t|
    t.integer "klass_id"
    t.integer "student_id"
  end

  create_table "klasses_subjects", :id => false, :force => true do |t|
    t.integer "subject_id"
    t.integer "klass_id"
  end

  create_table "recruiters", :force => true do |t|
    t.string   "arrival_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recruitments", :force => true do |t|
    t.integer  "student_id"
    t.integer  "recruiter_id"
    t.datetime "start_date"
    t.datetime "end_date"
  end

  create_table "school_users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", :force => true do |t|
    t.string   "birthdate"
    t.string   "address"
    t.string   "zip_code"
    t.string   "city"
    t.string   "home_phone_number"
    t.string   "mobile_phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects_teachers", :id => false, :force => true do |t|
    t.integer "subject_id"
    t.integer "teacher_id"
  end

  create_table "teachers", :force => true do |t|
    t.integer  "arrival_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trainings", :force => true do |t|
    t.string   "name"
    t.string   "section"
    t.string   "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                :default => "",    :null => false
    t.string   "encrypted_password",                   :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name",                           :default => ""
    t.string   "last_name",                            :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rolable_id"
    t.string   "rolable_type"
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.boolean  "is_admin",                             :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["first_name"], :name => "index_users_on_first_name"
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token"
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["last_name"], :name => "index_users_on_last_name"

end
