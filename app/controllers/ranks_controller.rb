class RanksController < ApplicationController
  def index
    max_date_id = MstDate.maximum(:id)
    @date_id = max_date_id
    @genre_id = 4 # J-pop
    @running_ranking = 1
    if !flash[:genre_name].nil? &&
       !flash[:target_date].nil? &&
       !flash[:running_ranking].nil?
      @target_date = flash[:target_date]
      @genre_name = flash[:genre_name]
      @running_ranking = flash[:running_ranking].to_i
    end
    @view_rankings = Rank.ranking(@date_id, @genre_id)
    @list_dates = MstDate.select(:id, :this_date)
    @list_genres = MstGenre.select(:id, :name)
  end

  def result
    @view_rankings = Rank.ranking(params[:target_date], params[:genre_name])
    @list_dates = MstDate.select(:id, :this_date)
    @list_genres = MstGenre.select(:id, :name)
    @running_ranking = 1
  end

  def next
    @view_rankings = Rank.ranking(params[:target_date], params[:genre_name])
    @list_dates = MstDate.select(:id, :this_date)
    @list_genres = MstGenre.select(:id, :name)
    @running_ranking = Rank.next_ranking(params[:running_ranking])
  end

  def prev
    @view_rankings = Rank.ranking(params[:target_date], params[:genre_name])
    @list_dates = MstDate.select(:id, :this_date)
    @list_genres = MstGenre.select(:id, :name)
    @running_ranking = Rank.prev_ranking(params[:running_ranking])
  end
end
