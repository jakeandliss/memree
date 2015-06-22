class AddIndexToContentType < ActiveRecord::Migration
  def change
  	add_index :images, :avatar_content_type
  end
end
