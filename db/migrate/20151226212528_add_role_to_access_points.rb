class AddRoleToAccessPoints < ActiveRecord::Migration
  def change
  	add_column :access_points, :role, :integer, :default => 0
  end
end
