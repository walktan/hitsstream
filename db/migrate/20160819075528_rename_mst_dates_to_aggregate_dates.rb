# Rename model
class RenameMstDatesToAggregateDates < ActiveRecord::Migration
  def change
    rename_column :mst_dates, :id, :aggregate_date_id
    rename_table :mst_dates, :aggregate_dates
  end
end
