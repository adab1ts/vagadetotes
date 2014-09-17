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

ActiveRecord::Schema.define(version: 20140917113536) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "endorsements", force: true do |t|
    t.string   "name"
    t.string   "lastname"
    t.string   "doctype"
    t.string   "docid"
    t.string   "email"
    t.date     "birthdate"
    t.string   "postal_code"
    t.string   "activity"
    t.boolean  "subscribed"
    t.boolean  "hidden"
    t.boolean  "featured"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "group"
  end

  add_index "endorsements", ["docid"], name: "index_endorsements_on_docid", unique: true, using: :btree
  add_index "endorsements", ["email"], name: "index_endorsements_on_email", unique: true, using: :btree
  add_index "endorsements", ["lastname"], name: "index_endorsements_on_lastname", using: :btree

end
