class CreateMstMusics < ActiveRecord::Migration
  def change
    create_table :mst_musics do |t|
      t.string :title
      t.string :artist
      t.text :url

      t.timestamps null: false
    end
  end
end
