class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true
      t.string :comment
      t.string :itemid
      t.string :commentaryid
      t.string :pid

      t.timestamps null: false
    end
    add_foreign_key :comments, :users
  end
end
