class Rank < ActiveRecord::Base
  belongs_to :mst_date
  belongs_to :mst_genre
  belongs_to :mst_music

  def self.ranking(date, genre)
  	ViewRanking.where(target_date: date, \
                      genre_name: genre).order("ranking")
  end

  def self.next_ranking(now_ranking)
  	if now_ranking != "10"
  		now_ranking.to_i + 1.to_i
  	else 1
  	end
  end

  def self.prev_ranking(now_ranking)
    if now_ranking != "1"
      now_ranking.to_i - 1.to_i
    else 10
    end
  end

end
