class CreateViewRankings < ActiveRecord::Migration
  def change
    create_view :view_rankings
  end
end
