class AddCommentaryidToTexts < ActiveRecord::Migration
  def change
  	add_column :texts, :commentaryid, :string
  end
end
