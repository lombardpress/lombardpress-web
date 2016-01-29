class AddAccessTypeToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :access_type, :integer
  end
end
