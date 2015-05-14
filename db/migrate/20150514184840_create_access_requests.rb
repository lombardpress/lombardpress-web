class CreateAccessRequests < ActiveRecord::Migration
  def change
    create_table :access_requests do |t|
      t.references :user, index: true
      t.string :itemid
      t.string :commentaryid
      t.string :note

      t.timestamps null: false
    end
    add_foreign_key :access_requests, :users
  end
end
