class ChangeUsersTextsTableName < ActiveRecord::Migration
  def change
  	rename_table :users_texts, :texts_users
  end
end
