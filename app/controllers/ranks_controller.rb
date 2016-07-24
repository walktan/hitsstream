class RanksController < ApplicationController

	def index
		max_date = MstDate.maximum(:this_date)
		@target_date = max_date
		@genre_name = "J-Pop"
		@running_ranking = 1
		if !flash[:name].nil? && !flash[:this_date].nil? && !flash[:now_ranking].nil?
			@target_date = flash[:this_date]
			@genre_name = flash[:name]
			@running_ranking = flash[:now_ranking].to_i
		end
		@view_rankings = ViewRanking.where(target_date: @target_date, genre_name: @genre_name).order('ranking')
		@mst_dates = MstDate.select(:id, :this_date)
		@mst_genres = MstGenre.select(:id, :name)
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
