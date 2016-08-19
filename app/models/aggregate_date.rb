# model
class AggregateDate < ActiveRecord::Base
  has_one :daily_ranking
end
