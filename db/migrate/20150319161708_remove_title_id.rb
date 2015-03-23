class RemoveTitleId < ActiveRecord::Migration
  def change
  	remove_column :entries, :titles_id
  end
end
