class CreateMstDates < ActiveRecord::Migration
  def change
    create_table :mst_dates do |t|
      t.date :this_time

      t.timestamps null: false
    end
  end
end
