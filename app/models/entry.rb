class Entry < ActiveRecord::Base
	belongs_to :user
	
	has_many :taggings
	has_many :tags, -> { uniq }, through: :taggings, :dependent => :destroy
	has_many :resources, dependent: :destroy

	default_scope { order('title_date DESC', 'created_at DESC') }
  	validates_presence_of :title

	include PgSearch

	pg_search_scope :text_search, against: [:title, :content], using: {tsearch: {dictionary: "english"}}

	#add or create tags 
	def add_tags(names)
		  self.tags = names.split(",").map do |name|
      		self.user.tags.where(name: name.strip, user_id: user_id).first_or_create!
      	end
	end

	# Get names of all tags related to this title
	def all_tags
		tags.map(&:name).join(", ")
	end

	def self.search(query = nil, dates = {})
		dates[:finish] ||= Date.current
		dates[:start] ||= Date.current - 2000.years

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
