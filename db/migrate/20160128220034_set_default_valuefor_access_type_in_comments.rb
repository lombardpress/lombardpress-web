class SetDefaultValueforAccessTypeInComments < ActiveRecord::Migration
  def change
  	change_column :comments, :access_type, :integer, :default => 0
  end
end
