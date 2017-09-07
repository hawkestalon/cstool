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

ActiveRecord::Schema.define(version: 20170906234441) do

  create_table "announcements", force: :cascade do |t|
    t.string "body"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attrecords", force: :cascade do |t|
    t.integer "PTO"
    t.integer "FMLA"
    t.integer "days"
    t.date "flexone"
    t.date "flextwo"
    t.date "flexthree"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_attrecords_on_user_id"
  end

  create_table "coaches", force: :cascade do |t|
    t.string "details"
    t.string "goals"
    t.string "reminder"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "correctives", force: :cascade do |t|
    t.string "description"
    t.string "supervisor"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date_of"
    t.string "supsig"
    t.string "agentsig"
    t.string "mansig"
    t.string "typeOf"
    t.string "plan"
    t.string "action"
    t.string "comments"
    t.index ["user_id"], name: "index_correctives_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "employee"
    t.integer "role"
    t.integer "team"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.integer "certLevel"
  end

end
