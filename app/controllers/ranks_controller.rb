class RanksController < ApplicationController
  def index
    max_date = MstDate.maximum(:this_date)
    @target_date = max_date
    @genre_name = "J-Pop"
    @running_ranking = 1
    if !flash[:genre_name].nil? &&
       !flash[:target_date].nil? &&
       !flash[:running_ranking].nil?
      @target_date = flash[:target_date]
      @genre_name = flash[:genre_name]
      @running_ranking = flash[:running_ranking].to_i
    end
    @view_rankings = Rank.ranking(@target_date, @genre_name)
    @mst_dates = MstDate.select(:id, :this_date)
    @mst_genres = MstGenre.select(:id, :name)
  end

  def result
    @view_rankings = Rank.ranking(params[:target_date], params[:genre_name])
    @mst_dates = MstDate.select(:id, :this_date)
    @mst_genres = MstGenre.select(:id, :name)
    @running_ranking = 1
  end

  def next
    @view_rankings = Rank.ranking(params[:target_date], params[:genre_name])
    @mst_dates = MstDate.select(:id, :this_date)
    @mst_genres = MstGenre.select(:id, :name)
    @running_ranking = Rank.next_ranking(params[:running_ranking])
  end

  def prev
    @view_rankings = Rank.ranking(params[:target_date], params[:genre_name])
    @mst_dates = MstDate.select(:id, :this_date)
    @mst_genres = MstGenre.select(:id, :name)
    @running_ranking = Rank.prev_ranking(params[:running_ranking])
  end
end
