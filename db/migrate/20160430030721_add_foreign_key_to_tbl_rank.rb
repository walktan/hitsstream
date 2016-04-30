class AddForeignKeyToTblRank < ActiveRecord::Migration
  def change
  	change_table :tbl_ranks do |t|
  		t.belongs_to :mstdates, options: 'ON UPDATE CASCADE ON DELETE CASCADE'
  		t.belongs_to :mstgenres, options: 'ON UPDATE CASCADE ON DELETE CASCADE'
  		t.belongs_to :mstmusics, options: 'ON UPDATE CASCADE ON DELETE CASCADE'
  	end
  end
end
