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

ActiveRecord::Schema.define(version: 20170311200246) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "b_good_users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "phone_number"
    t.string   "auth0_id"
    t.integer  "referer"
    t.index ["phone_number"], name: "index_b_good_users_on_phone_number", unique: true, using: :btree
  end

  create_table "challenges", force: :cascade do |t|
    t.string   "details"
    t.date     "date"
    t.string   "challenge_type"
    t.boolean  "completed"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "b_good_user_id"
    t.integer  "opportunity_id"
    t.index ["b_good_user_id"], name: "index_challenges_on_b_good_user_id", using: :btree
    t.index ["opportunity_id"], name: "index_challenges_on_opportunity_id", using: :btree
  end

  create_table "opportunities", force: :cascade do |t|
    t.string   "api_id"
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "organization"
    t.date     "date"
    t.time     "time"
    t.string   "link"
  end

  add_foreign_key "challenges", "b_good_users"
  add_foreign_key "challenges", "opportunities"
end
