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

ActiveRecord::Schema.define(version: 20160710100308) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "mst_dates", force: :cascade do |t|
    t.date     "this_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mst_genres", force: :cascade do |t|
    t.string   "name"
    t.string   "itunes_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mst_musics", force: :cascade do |t|
    t.string   "title"
    t.string   "artist"
    t.text     "youtube_url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
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
  add_foreign_key "ranks", "mst_genres"
  add_foreign_key "ranks", "mst_musics"

  create_view :view_rankings,  sql_definition: <<-SQL
      SELECT md.this_date AS target_date,
      mg.name AS genre_name,
      r.rank AS ranking,
      mm.artist,
      mm.title,
      mm.youtube_url,
      mm.id AS mst_music_id
     FROM ranks r,
      mst_dates md,
      mst_genres mg,
      mst_musics mm
    WHERE (((r.mst_date_id = md.id) AND (r.mst_genre_id = mg.id)) AND (r.mst_music_id = mm.id));
  SQL

end
