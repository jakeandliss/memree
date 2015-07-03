class Entry < ActiveRecord::Base
	belongs_to :user

	has_many :entry_shareable, dependent: :destroy
	has_many :shared_users, through: :entry_shareable, source: :user
	has_many :group_shareables, dependent: :destroy
	has_many :shared_groups, through: :group_shareables, source: :group
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
	def all_tags(user_id)
		tags.where(user_id: user_id).map(&:name).join(", ")
	end

	def sortable_date
	  title_date.to_datetime
	end

	# Add tags for a new entry
	def add_tags(names)
		  self.tags = names.split(",").map do |name|
      		User.find_by(:id => user.id).tags.where(name: name.strip).first_or_create!
      	end
	end
	
	def update_tags_for_user(names, c_user)
		mul_tags = names.split(",")
		new_tags = []
		new_taggings = []
		mul_tags.each do |name|
			tag = c_user.tags.find_or_create_by name: name
			new_tags.push tag
			new_taggings.push taggings.find_or_create_by(tag_id: tag.id)
		end
		(taggings.where(user_id: c_user.id) - new_taggings).map(&:destroy)
		new_tags
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
      		User.where(email: id.strip).first || User.invite!(email: id.strip){|u| u.skip_invitation = true }
      end
	end

	# Add users for a new entry
	def add_user(user_params)
		user = User.find_by_email(user_params[:email])
		user ||= User.invite!(user_params){|u| u.skip_invitation = true }
		self.shared_users << user unless user.id == user_id
		user
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

	def is_hidden_for?(user)
		entry_shareable.where(user: user).first.try(:is_hidden?)
	end

end
