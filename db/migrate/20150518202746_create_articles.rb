class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :article_name
      t.string :xml_file
      t.string :xslt_file
      t.references :setting, index: true
      t.timestamps null: false
    end
    add_foreign_key :articles, :settings
  end
end
