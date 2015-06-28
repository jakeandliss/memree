class Group < ActiveRecord::Base

  # Scopes (Custom Queries)
  default_scope { order('created_at DESC') } 

  # Associations
  belongs_to :user
  has_many :group_members, dependent: :destroy
  has_many :members, through: :group_members, source: :user

  # Validations
  validates :name, :user_id, presence: true

end
