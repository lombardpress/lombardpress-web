class ChangeColumnAndIndexInAccessPointUserTable < ActiveRecord::Migration
  def change
  	rename_column :access_points_users, :text_id, :access_point_id
  end
end
