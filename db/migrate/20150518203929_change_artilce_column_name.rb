class ChangeArtilceColumnName < ActiveRecord::Migration
  def change
  	rename_column :articles, :article_id, :article_name
  end
end
