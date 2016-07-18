class RanksController < ApplicationController

	def index
		# 日付の取得
		today = Date.today
		@view_rankings = ViewRanking.where(target_date: today, genre_name: "J-Pop").order('ranking')
		@mst_dates = MstDate.select(:id, :this_date)
		@mst_genres = MstGenre.select(:id, :name)
		@running_ranking = 1
	end

	def result
		@view_rankings = ViewRanking.where(target_date: params[:this_date], genre_name: params[:name]).order('ranking')
		@mst_dates = MstDate.select(:id, :this_date)
		@mst_genres = MstGenre.select(:id, :name)
		@running_ranking = 1
	end

	def next
		@view_rankings = ViewRanking.where(target_date: params[:this_date], genre_name: params[:name]).order('ranking')
		@mst_dates = MstDate.select(:id, :this_date)
		@mst_genres = MstGenre.select(:id, :name)
		next_ranking = 1
		if params[:now_ranking] != '10'
			next_ranking = params[:now_ranking].to_i + 1.to_i
		end
		@running_ranking = next_ranking
	end

end
