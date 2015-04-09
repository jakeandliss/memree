class AddAttachmentToImage < ActiveRecord::Migration
  def change
    remove_column :images, :avatar
    add_attachment :images, :avatar
  end
end
