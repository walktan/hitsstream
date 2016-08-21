# controller
class DailyRankingsController < ApplicationController
  def index
    max_date_id = AggregateDate.maximum(:aggregate_date_id)
    @aggregate_date_id = max_date_id
    @itune_id = 1 # J-pop
    @running_ranking = 1
    if !flash[:itune_id].nil? &&
       !flash[:target_date_id].nil? &&
       !flash[:running_ranking].nil?
      @target_date_id = flash[:target_date_id]
      @itune_id = flash[:itune_id]
      @running_ranking = flash[:running_ranking].to_i
    end
    @view_rankings = DailyRanking.ranking(@aggregate_date_id, @itune_id)
    @list_dates = AggregateDate.select(:aggregate_date_id, :this_date)
    @list_genres = Itune.select(:itune_id, :genre)
  end

  def result
    @view_rankings = DailyRanking.ranking(params[:target_date_id],
                                          params[:itune_id])
    @list_dates = AggregateDate.select(:aggregate_date_id, :this_date)
    @list_genres = Itune.select(:itune_id, :genre)
    @running_ranking = 1
  end

  def next
    @view_rankings = DailyRanking.ranking(params[:target_date_id],
                                          params[:itune_id])
    @list_dates = AggregateDate.select(:aggregate_date_id, :this_date)
    @list_genres = Itune.select(:itune_id, :genre)
    @running_ranking = DailyRanking.next_ranking(params[:running_ranking])
  end

  def prev
    @view_rankings = DailyRanking.ranking(params[:target_date_id],
                                          params[:itune_id])
    @list_dates = AggregateDate.select(:aggregate_date_id, :this_date)
    @list_genres = Itune.select(:itune_id, :genre)
    @running_ranking = DailyRanking.prev_ranking(params[:running_ranking])
  end
end
