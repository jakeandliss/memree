class AddIsHiddenToEntryShareables < ActiveRecord::Migration
  def change
    add_column :entry_shareables, :is_hidden, :boolean, default: false
  end
end
