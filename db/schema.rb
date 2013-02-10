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

ActiveRecord::Schema.define(:version => 20130131155343) do

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "results", :force => true do |t|
    t.integer  "subtask_id"
    t.integer  "user_id"
    t.integer  "question_score"
    t.text     "comment"
    t.datetime "time_begin"
    t.datetime "time_end"
    t.datetime "time_break"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "workflow_state"
  end

  add_index "results", ["subtask_id"], :name => "index_results_on_subtask_id"
  add_index "results", ["user_id"], :name => "index_results_on_user_id"

  create_table "subtasks", :force => true do |t|
    t.text     "description"
    t.text     "title"
    t.integer  "task_id"
    t.text     "question"
    t.integer  "results_id"
    t.boolean  "enabled"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "type_question"
  end

  add_index "subtasks", ["results_id"], :name => "index_subtasks_on_results_id"
  add_index "subtasks", ["task_id"], :name => "index_subtasks_on_task_id"

  create_table "tasks", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "tasks", ["project_id"], :name => "index_tasks_on_project_id"

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
    t.boolean  "admin"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
