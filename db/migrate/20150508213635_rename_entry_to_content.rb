class RenameEntryToContent < ActiveRecord::Migration
  def change

  	rename_column :entries, :entry, :content
  end
end
