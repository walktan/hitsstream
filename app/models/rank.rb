class Rank < ActiveRecord::Base
  belongs_to :mst_date
  belongs_to :mst_genre
  belongs_to :mst_music

  RANK_MAX = 10
  RANK_MIN = 1

  def self.ranking(date, genre)
    Ranking.where(target_date: date, \
                  genre_name: genre).order("ranking")
  end

  def self.next_ranking(now_ranking)
    now_ranking.to_i == RANK_MAX ? RANK_MIN : now_ranking.to_i + 1
  end

  def self.prev_ranking(now_ranking)
    now_ranking.to_i == RANK_MIN ? RANK_MAX : now_ranking.to_i - 1
  end
end
