class AddForeignKeyToRanks < ActiveRecord::Migration
def change
    change_table :ranks do |t|
      add_foreign_key(:ranks, :mst_genres, options: 'ON UPDATE CASCADE ON DELETE CASCADE')
      add_foreign_key(:ranks, :mst_musics, options: 'ON UPDATE CASCADE ON DELETE CASCADE')
      add_foreign_key(:ranks, :mst_dates, options: 'ON UPDATE CASCADE ON DELETE CASCADE')
    end
  end
end