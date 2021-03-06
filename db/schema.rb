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

ActiveRecord::Schema.define(version: 20150121023015) do

  create_table "countries", force: :cascade do |t|
    t.string "name",     limit: 255
    t.string "code",     limit: 255
    t.string "currency", limit: 255
  end

  create_table "messages", force: :cascade do |t|
    t.string   "subject",    limit: 255
    t.string   "body",       limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "subscription_prices", force: :cascade do |t|
    t.float    "price",      limit: 24
    t.integer  "country_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "subscription_prices", ["country_id"], name: "fk_rails_0388baf101", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id",             limit: 4
    t.float    "amount_paid",         limit: 24
    t.integer  "currency_country_id", limit: 4
    t.datetime "activated_at"
    t.datetime "cancelled_at"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "subscriptions", ["currency_country_id"], name: "fk_rails_17dbbae847", using: :btree
  add_index "subscriptions", ["user_id"], name: "fk_rails_9fa78738a1", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "age",        limit: 4
    t.string   "gender",     limit: 255
    t.integer  "country_id", limit: 4
  end

  add_index "users", ["country_id"], name: "fk_rails_c3b920faa0", using: :btree

  add_foreign_key "messages", "users"
  add_foreign_key "subscription_prices", "countries"
  add_foreign_key "subscriptions", "countries", column: "currency_country_id"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "users", "countries"
end
