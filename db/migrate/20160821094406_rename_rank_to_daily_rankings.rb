# Rename model
class RenameRankToDailyRankings < ActiveRecord::Migration
  def change
    rename_column :ranks, :id, :daily_ranking_id
    rename_column :ranks, :mst_date_id, :aggregate_date_id
    rename_column :ranks, :mst_genre_id, :itune_id
    rename_column :ranks, :mst_music_id, :youtube_id
    rename_table :ranks, :daily_rankings
  end
end
