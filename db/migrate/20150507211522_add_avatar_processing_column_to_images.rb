class AddAvatarProcessingColumnToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :avatar_processing, :boolean
  end

  def self.down
    remove_column :images, :avatar_processing
  end
end
