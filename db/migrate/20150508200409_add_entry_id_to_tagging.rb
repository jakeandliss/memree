class AddEntryIdToTagging < ActiveRecord::Migration
  def change

  	remove_column :taggings, :title_id
  	add_reference :taggings, :entry, index: true, foreign_key: true
  
  end
end
