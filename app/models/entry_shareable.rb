class EntryShareable < ActiveRecord::Base
	belongs_to :user
	belongs_to :entry

	after_create :create_share_tag
	after_create :send_notification_to_user

	default_scope { where(is_hidden: false) }

	private
	def create_share_tag
		tag = user.tags.where(name: "Shared").first_or_create!
		entry.taggings.create(tag: tag)
	end

	def send_notification_to_user
		Notifier.send_share_notification(self).deliver_later
	end
end
