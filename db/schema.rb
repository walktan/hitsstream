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

ActiveRecord::Schema.define(version: 20160619115246) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "mst_dates", force: :cascade do |t|
    t.date     "this_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mst_genres", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mst_musics", force: :cascade do |t|
    t.string   "title"
    t.string   "artist"
    t.text     "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ranks", force: :cascade do |t|
    t.integer  "rank"
    t.integer  "mst_date_id"
    t.integer  "mst_genre_id"
    t.integer  "mst_music_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "ranks", ["mst_date_id"], name: "index_ranks_on_mst_date_id", using: :btree
  add_index "ranks", ["mst_genre_id"], name: "index_ranks_on_mst_genre_id", using: :btree
  add_index "ranks", ["mst_music_id"], name: "index_ranks_on_mst_music_id", using: :btree

  add_foreign_key "ranks", "mst_dates"
  add_foreign_key "ranks", "mst_dates", name: "ranks_mst_date_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "ranks", "mst_genres"
  add_foreign_key "ranks", "mst_genres", name: "ranks_mst_genre_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "ranks", "mst_musics"
  add_foreign_key "ranks", "mst_musics", name: "ranks_mst_music_id_fk", on_update: :cascade, on_delete: :cascade
end
