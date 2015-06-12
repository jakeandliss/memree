class EntryShareable < ActiveRecord::Base
	belongs_to :user
	belongs_to :entry

	after_create :create_share_tag

	private
	def create_share_tag
			tag = user.tags.where(name: "Shared").first_or_create!
			entry.taggings.create(tag: tag)
	end
end
