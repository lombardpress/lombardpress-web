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
      t.timestamps null: false
      t.boolean :images
    end
    
  end
end
