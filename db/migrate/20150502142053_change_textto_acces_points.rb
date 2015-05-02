class ChangeTexttoAccesPoints < ActiveRecord::Migration
  def change
 	 rename_table :texts, :access_points
	end
end
