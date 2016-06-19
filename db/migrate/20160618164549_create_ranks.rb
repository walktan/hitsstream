class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.integer :rank
      t.references :mst_date, index: true, foreign_key: true
      t.references :mst_genre, index: true, foreign_key: true
      t.references :mst_music, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
