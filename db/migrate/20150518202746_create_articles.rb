class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :article_id
      t.string :xml_file
      t.string :xslt_file
      t.references :setting_id, index: true

      t.timestamps null: false
    end
    add_foreign_key :articles, :setting_ids
  end
end
