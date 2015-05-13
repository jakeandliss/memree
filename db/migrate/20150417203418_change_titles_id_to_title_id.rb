class ChangeTitlesIdToTitleId < ActiveRecord::Migration
  def change
  	add_column :entries, :title_id, :integer
  end
end
