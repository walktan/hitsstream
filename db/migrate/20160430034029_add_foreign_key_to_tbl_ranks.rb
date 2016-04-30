class AddForeignKeyToTblRanks < ActiveRecord::Migration
  def change
  		add_foreign_key(:tbl_ranks, :mst_dates, options: 'ON UPDATE CASCADE ON DELETE CASCADE')
  		add_foreign_key(:tbl_ranks, :mst_genres, options: 'ON UPDATE CASCADE ON DELETE CASCADE')
  		add_foreign_key(:tbl_ranks, :mst_musics, options: 'ON UPDATE CASCADE ON DELETE CASCADE')
  end
end
