class ChangeUserTextidsTableName < ActiveRecord::Migration
  def change
  	rename_table :user_textids, :users_texts
  end
end
