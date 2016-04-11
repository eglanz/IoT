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

ActiveRecord::Schema.define(version: 20160411194252) do

  create_table "bloodpressures", force: :cascade do |t|
    t.integer  "testid",            limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "bort",              limit: 4
    t.float    "min_diastolic",     limit: 24
    t.float    "min_systolic",      limit: 24
    t.float    "max_diastolic",     limit: 24
    t.float    "max_systolic",      limit: 24
    t.float    "average_diastolic", limit: 24
    t.float    "average_systolic",  limit: 24
  end

  create_table "hearts", force: :cascade do |t|
    t.integer  "testid",     limit: 4
    t.float    "min",        limit: 24
    t.float    "max",        limit: 24
    t.float    "average",    limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "bort",       limit: 4
  end

  create_table "startstatuses", force: :cascade do |t|
    t.integer  "start",      limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "tests", force: :cascade do |t|
    t.string   "patient_name", limit: 255
    t.string   "video",        limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "teststatuses", force: :cascade do |t|
    t.integer  "testid",     limit: 4
    t.integer  "status",     limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

end
