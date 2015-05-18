class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :commentaryid
      t.string :logo
      t.text :title
      t.text :bannermessage
      t.boolean :blog
      t.string :default_ms_image
      t.string :dark_color
      t.string :light_color
      t.string :commentarydirname
      t.references :article_id, index: true

      t.timestamps null: false
    end
    add_foreign_key :settings, :article_ids
  end
end
