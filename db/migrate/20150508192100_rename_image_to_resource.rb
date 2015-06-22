class RenameImageToResource < ActiveRecord::Migration
  def change
  	rename_table :images, :resources
	drop_table :entries
	rename_table :titles, :entries
  end
end
