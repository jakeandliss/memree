class GroupMember < ActiveRecord::Base

  # Associations
  belongs_to :group
  belongs_to :user

  # Validations
  validates :group_id, :user_id, presence: true

end
