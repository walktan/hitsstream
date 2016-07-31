# Rename viewname
class RenameViewRankingToRanking < ActiveRecord::Migration
  def change
    drop_view :view_rankings
    create_view :rankings
  end
end
