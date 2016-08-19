class Rank < ActiveRecord::Base
  belongs_to :mst_date
  belongs_to :mst_genre
  belongs_to :mst_music

  RANK_MAX = 10
  RANK_MIN = 1

  def self.ranking(date, genre)
    Rank.joins(:mst_date, :mst_genre, :mst_music).
      select("mst_dates.id AS target_date_id \
                ,mst_dates.this_date AS target_date \
                ,mst_genres.id AS genre_id \
                ,mst_genres.name AS genre_name \
                ,ranks.rank AS ranking \
                ,mst_musics.artist AS artist \
                ,mst_musics.title AS title \
                ,mst_musics.youtube_url AS youtube_url \
                ,mst_musics.id AS mst_music_id").
      where(mst_date_id: date, mst_genre_id: genre).order('rank')
  end

  def self.next_ranking(now_ranking)
    now_ranking.to_i == RANK_MAX ? RANK_MIN : now_ranking.to_i + 1
  end

  def self.prev_ranking(now_ranking)
    now_ranking.to_i == RANK_MIN ? RANK_MAX : now_ranking.to_i - 1
  end
end
