# model
class DailyRanking < ActiveRecord::Base
  belongs_to :aggregate_date
  belongs_to :itune
  belongs_to :youtube
  validates  :aggregate_date_id , presence: true
  validates  :itune_id          , presence: true
  validates  :youtube_id        , presence: true
  validates  :rank              , presence: true \
                                , inclusion: { in: 1..10 }

  RANK_MAX = 10
  RANK_MIN = 1

  def self.ranking(aggregate_date_id, itune_id)
    DailyRanking.joins(:aggregate_date, :itune, :youtube) \
                .select('daily_rankings.*, aggregate_dates.*, itunes.*, youtubes.*') \
                .where(aggregate_date_id: aggregate_date_id, itune_id: itune_id) \
                .order('rank')
  end

  def self.next_ranking(now_ranking)
    now_ranking.to_i == RANK_MAX ? RANK_MIN : now_ranking.to_i + 1
  end

  def self.prev_ranking(now_ranking)
    now_ranking.to_i == RANK_MIN ? RANK_MAX : now_ranking.to_i - 1
  end
end
