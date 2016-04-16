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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160416154316) do

  create_table "blockers", force: :cascade do |t|
    t.integer  "session_id"
    t.integer  "user_id"
    t.text     "blocker"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "completeds", force: :cascade do |t|
    t.integer  "session_id"
    t.integer  "user_id"
    t.text     "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions_users", force: :cascade do |t|
    t.integer  "session_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sessions_users", ["session_id"], name: "index_sessions_users_on_session_id"
  add_index "sessions_users", ["user_id"], name: "index_sessions_users_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "session_id"
    t.boolean  "attended",   default: false
  end

  create_table "wips", force: :cascade do |t|
    t.integer  "session_id"
    t.integer  "user_id"
    t.text     "wip_item"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
