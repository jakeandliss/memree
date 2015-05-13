class Entry < ActiveRecord::Base
	belongs_to :user
	
	has_many :taggings
	has_many :tags, -> { uniq }, through: :taggings, :dependent => :destroy
	has_many :resources, dependent: :destroy

	default_scope { order('created_at DESC') }
  	validates_presence_of :title

 	#  validate :at_least_one

	# def at_least_one
	#   if [self.resource_ids, self.content].reject(&:blank?).size == 0
 	#   errors.add(:message, 'You need at least one field.')
	#   end
	# end


	# Add tags for a new title
	def add_tags(tag_names="")
		tag_names.split(',').map do |tag_name|
			if tag = user.tags.find_by(name: tag_name.strip.downcase)
				taggings.find_or_create_by(tag_id: tag.id, entry_id: id)
			else
				tags.find_or_create_by(name: tag_name.strip.downcase, user_id: user_id)
			end
		end
	end

	# Get names of all tags related to this title
	def all_tags
		tags.map(&:name).join(", ")
	end

	# Find all titles whish has a specified name
	def self.tagged_with(name)
		Tag.find_by_name!(name).titles
	end

	# Retrive all titles having with tag or child of this tag
	def self.childrens_of tag
		# Get identifiers of specified tag and its children
	    title_ids = Tagging.where(tag_id: tag.subtree_ids).pluck(:entry_id)

	    # Find titles with ids from the array title_ids
		Entry.where(id: title_ids.uniq)
	end


	
end
