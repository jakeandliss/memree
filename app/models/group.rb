class Group < ActiveRecord::Base

  # Associations
  belongs_to :user
  has_many :group_members
  has_many :members, through: :group_members, source: :user

  # Validations
  validates :name, :user_id, presence: true

end
