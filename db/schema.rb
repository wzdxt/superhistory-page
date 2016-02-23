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

ActiveRecord::Schema.define(version: 20160223032805) do

  create_table "locks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pages", force: :cascade do |t|
    t.string   "url",             limit: 1000
    t.integer  "target_page_id"
    t.integer  "status"
    t.integer  "content_hash",    limit: 8
    t.integer  "content_version"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "http_status"
  end

  add_index "pages", ["content_hash"], name: "index_pages_on_content_hash"

end
