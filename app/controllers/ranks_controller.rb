class RanksController < ApplicationController

	def index
		# 日付の取得
		today = Date.today
		@view_rankings = ViewRanking.where(target_date: today, genre_name: "J-Pop")
		@mst_dates = MstDate.new
		@mst_genres = MstGenre.new
	end

end
