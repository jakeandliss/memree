class Title < ActiveRecord::Base
	belongs_to :user
	has_many :entries, :dependent => :destroy

	accepts_nested_attributes_for :entries
	
	validates :title, presence: true
end
