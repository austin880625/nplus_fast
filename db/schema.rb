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

ActiveRecord::Schema.define(version: 2018_06_28_185729) do

  create_table "messages", force: :cascade do |t|
    t.integer "send_from"
    t.integer "send_to"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ride_histories", force: :cascade do |t|
    t.integer "user_id"
    t.integer "ride_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ride_memberships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "ride_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rides", force: :cascade do |t|
    t.string "title"
    t.string "time_start"
    t.string "time_end"
    t.string "description"
    t.string "from"
    t.string "to"
    t.integer "vehicle"
    t.integer "num_passenger_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "driver"
    t.integer "created_by"
  end

  create_table "tokens", force: :cascade do |t|
    t.string "content"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content"], name: "index_tokens_on_content", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password"
    t.string "liked_gift"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
