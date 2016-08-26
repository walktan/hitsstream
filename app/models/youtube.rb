# model
class Youtube < ActiveRecord::Base
  has_one :daily_ranking
  validates :artist, presence: true \
                   , length: { maximum: 80 } \
                   , uniqueness: { scope: [:title] }
  validates :title , presence: true \
                   , length: { maximum: 50}
end
