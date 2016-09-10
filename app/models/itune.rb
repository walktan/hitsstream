# model
class Itune < ActiveRecord::Base
  has_one :daily_ranking
  validates :genre     , presence: true \
                       , uniqueness: true \
                       , length: { maximum: 30 }
  validates :itunes_url, presence: true \
                       , format: /\A#{URI::regexp(%w(http https))}\z/
end
