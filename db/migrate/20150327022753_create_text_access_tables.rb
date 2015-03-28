class CreateTextAccessTables < ActiveRecord::Migration
  def change
    
    create_table :texts do |t|
      t.string :textid
      t.timestamps null: false
    end
 
    create_table :user_textids, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :text, index: true
    end
  end

end
