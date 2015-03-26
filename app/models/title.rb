class Title < ActiveRecord::Base
	belongs_to :user
	has_many :entries, :dependent => :destroy
	accepts_nested_attributes_for :entries
	validates :title, presence: true
	has_many :taggings
	has_many :tags, -> { uniq }, through: :taggings

	def all_tags=(names)
		self.tags = names.split(',').map do |name|
			Tag.where(name: name.strip).first_or_create!
		end
	end

	def all_tags
		self.tags.map(&:name).join(", ")
	end

	def self.tagged_with(name)
		Tag.find_by_name!(name).titles
	end
end
