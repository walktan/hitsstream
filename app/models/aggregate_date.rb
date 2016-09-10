# model
class AggregateDate < ActiveRecord::Base
  has_one :daily_ranking
  validates :this_date, presence: true \
                      , uniqueness: true
end
