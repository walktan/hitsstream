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

ActiveRecord::Schema.define(version: 20160821094406) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "aggregate_dates", primary_key: "aggregate_date_id", force: :cascade do |t|
    t.date     "this_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "daily_rankings", primary_key: "daily_ranking_id", force: :cascade do |t|
    t.integer  "rank"
    t.integer  "aggregate_date_id"
    t.integer  "itune_id"
    t.integer  "youtube_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "daily_rankings", ["aggregate_date_id"], name: "index_daily_rankings_on_aggregate_date_id", using: :btree
  add_index "daily_rankings", ["itune_id"], name: "index_daily_rankings_on_itune_id", using: :btree
  add_index "daily_rankings", ["youtube_id"], name: "index_daily_rankings_on_youtube_id", using: :btree

  create_table "itunes", primary_key: "itune_id", force: :cascade do |t|
    t.string   "genre"
    t.string   "itunes_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "youtubes", primary_key: "youtube_id", force: :cascade do |t|
    t.string   "title"
    t.string   "artist"
    t.text     "youtube_url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "daily_rankings", "aggregate_dates", primary_key: "aggregate_date_id"
  add_foreign_key "daily_rankings", "itunes", primary_key: "itune_id"
  add_foreign_key "daily_rankings", "youtubes", primary_key: "youtube_id"
end
