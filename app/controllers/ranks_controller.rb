class RanksController < ApplicationController

	def index
		# 日付の取得
		today = Date.today
		@view_rankings = ViewRanking.where(target_date: today, genre_name: "J-Pop")
		@mst_dates = MstDate.select(:id, :this_date)
		@mst_genres = MstGenre.select(:id, :name)
	end

	def result
		@view_rankings = ViewRanking.where(target_date: params[:this_date], genre_name: params[:name])
		@mst_dates = MstDate.select(:id, :this_date)
		@mst_genres = MstGenre.select(:id, :name)
	end


end
