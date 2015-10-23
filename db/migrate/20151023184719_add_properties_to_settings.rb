class AddPropertiesToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :properties, :text
  end
end
