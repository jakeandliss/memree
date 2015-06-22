class AddIndexToTags < ActiveRecord::Migration
  def change
    add_index :tags, :ancestry
  end
end
