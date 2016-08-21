# Rename model
class RenameMstMusicsToYoutubes < ActiveRecord::Migration
  def change
    rename_column :mst_musics, :id, :youtube_id
    rename_table :mst_musics, :youtubes
  end
end
