class RenameMstGenresToItunes < ActiveRecord::Migration
  def change
    rename_column :mst_genres, :id, :itune_id
    rename_column :mst_genres, :name, :genre
    rename_table :mst_genres, :itunes
  end
end
