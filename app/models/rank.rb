class Rank < ActiveRecord::Base
	belongs_to :mst_date
	belongs_to :mst_genre
	belongs_to :mst_music
end
