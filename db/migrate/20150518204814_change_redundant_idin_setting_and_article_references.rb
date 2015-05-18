class ChangeRedundantIdinSettingAndArticleReferences < ActiveRecord::Migration
  def change
  	rename_column :articles, :setting_id_id, :setting_id
  	rename_column :settings, :article_id_id, :article_id
  end
end
