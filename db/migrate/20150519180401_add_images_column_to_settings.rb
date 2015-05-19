class AddImagesColumnToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :images, :boolean
  end
end
