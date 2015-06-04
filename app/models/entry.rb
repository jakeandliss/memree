class Entry < ActiveRecord::Base
	belongs_to :user
	
	has_many :entry_shareable
	has_many :shared_users, through: :entry_shareable, source: :user
	has_many :taggings
	has_many :tags, -> { uniq }, through: :taggings, :dependent => :destroy
	has_many :resources, dependent: :destroy

	default_scope { order('title_date DESC', 'created_at DESC') }
  	validates_presence_of :title

 	#  validate :at_least_one

	# def at_least_one
	#   if [self.resource_ids, self.content].reject(&:blank?).size == 0
 	#   errors.add(:message, 'You need at least one field.')
	#   end
	# end

	include PgSearch

	pg_search_scope :text_search, against: [:title, :content], using: {tsearch: {dictionary: "english"}}


	# Get names of all tags related to this entry
	def all_tags
		tags.map(&:name).join(", ")
	end

	# Add tags for a new entry
	def add_tags(names)
		  self.tags = names.split(",").map do |name|
      		Tag.where(name: name.strip).first_or_create!
      	end
	end
		# def add_tags(tag_names="")
	# 	tag_names.split(',').map do |tag_name|
	# 		if tag = user.tags.find_by(name: tag_name.strip)
	# 			taggings.find_or_create_by(tag_id: tag.id, entry_id: id)
	# 		else
	# 			tags.find_or_create_by(name: tag_name.strip, user_id: user_id)
	# 		end
	# 	end
	# end

	# Get ids of all users related to this entry
	def all_users
		shared_users.map(&:id).join(", ")
	end

	# Add users for a new entry
	def add_users(ids)
		  self.shared_users = ids.split(",").map do |id|
      		User.where(id: id.strip).first_or_create!
      	end
	end

	# Find all titles whish has a specified name
	def self.tagged_with(name)
		Tag.find_by_name!(name).titles
	end


	def self.search(query = nil, dates = {})
		dates[:finish] ||= Date.current
		dates[:start] ||= Date.current - 200.years

	   result = where(:title_date => dates[:start].beginning_of_day..dates[:finish].end_of_day)

	   if query && !query.empty?
	       res = result.text_search(query)
		   if res.empty? 
		     result = result.where("LOWER(content) LIKE :q OR LOWER(title) LIKE :q", q: "%#{query.downcase}%") if query.present?
		   else
		   	 result = res
		   end
	   end

	   return result
	end

	# Retrive all titles having with tag or child of this tag
	def self.childrens_of tag
		# Get identifiers of specified tag and its children
	    title_ids = Tagging.where(tag_id: tag.subtree_ids).pluck(:entry_id)
	    # Find titles with ids from the array title_ids
		Entry.where(id: title_ids.uniq)
	end


	
end
