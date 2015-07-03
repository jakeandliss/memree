class GroupShareable < ActiveRecord::Base
  # Associations
  belongs_to :entry
  belongs_to :group

  # Callbacks
  after_create :create_entry_shareables
  before_destroy :remove_entry_shareables

  private
  def create_entry_shareables
    members = group.group_members
    members.each do |mem|
      entry.entry_shareable.create(user_id: mem.user_id, is_group_shared: true, group_id: group.id)
    end
  end

  def remove_entry_shareables
    members = group.group_members
    members.each do |mem|
      se = entry.entry_shareable.unscoped.where(user_id: mem.user_id, is_group_shared: true, group_id: group.id).first
      se.destroy if se
    end
  end
end
