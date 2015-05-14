class AddStatusColumnToAccessRequest < ActiveRecord::Migration
  def change
  	add_column :access_requests, :status, :integer
  end
end
