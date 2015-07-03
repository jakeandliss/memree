class AddIsGroupSharedToEntryShareables < ActiveRecord::Migration
  def change
    add_column :entry_shareables, :is_group_shared, :boolean, default: false
    add_column :entry_shareables, :group_id, :integer
  end
end
