class Entry < ActiveRecord::Base
  belongs_to :title
  validates :entry, presence: true
end
