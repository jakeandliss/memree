class AddUsedSpaceToUser < ActiveRecord::Migration
  def change
  	add_column :resources, :file_size, :bigint
  end
end
