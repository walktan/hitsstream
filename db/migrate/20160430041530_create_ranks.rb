class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.integer :rank
      t.integer :mst_date_id
      t.integer :mst_genre_id
      t.integer :mst_music_id

      t.timestamps null: false
    end
  end
end
