class ChangeTextTextidColumnToItemid < ActiveRecord::Migration
  def change
  	rename_column :texts, :textid, :itemid
  end
end
