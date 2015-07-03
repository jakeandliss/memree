class Group < ActiveRecord::Base

  # Scopes (Custom Queries)
  default_scope { order('created_at DESC') } 

  # Associations
  belongs_to :user
  has_many :group_members, dependent: :destroy
  has_many :members, through: :group_members, source: :user
  has_many :group_shareables, dependent: :destroy
  has_many :shared_entries, through: :group_shareables, source: :entry

  # Validations
  validates :name, :user_id, presence: true

end
