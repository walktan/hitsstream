class CreateMstGenres < ActiveRecord::Migration
  def change
    create_table :mst_genres do |t|
      t.string :name
      t.string :itunes_url

      t.timestamps null: false
    end
  end
end
