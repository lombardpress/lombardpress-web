class ChangeTextsUsersToAccessPointsUsers < ActiveRecord::Migration
  def change
  	rename_table :texts_users, :access_points_users
  end
end
