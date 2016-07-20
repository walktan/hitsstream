class RanksController < ApplicationController

	def index
		max_date = MstDate.maximum(:this_date)
		@view_rankings = ViewRanking.where(target_date: max_date, genre_name: "J-Pop").order('ranking')
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

	def prev
		@view_rankings = ViewRanking.where(target_date: params[:this_date], genre_name: params[:name]).order('ranking')
		@mst_dates = MstDate.select(:id, :this_date)
		@mst_genres = MstGenre.select(:id, :name)
		prev_ranking = 10
		if params[:now_ranking] != '1'
			prev_ranking = params[:now_ranking].to_i - 1.to_i
		end
		@running_ranking = prev_ranking
	end

end
