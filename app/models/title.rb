class Title < ActiveRecord::Base
	belongs_to :user
	validates :title, presence: true
	has_many :taggings
	has_many :tags, -> { uniq }, through: :taggings, :dependent => :destroy
	default_scope { order('created_at DESC') }
	has_many :images, as: :imageable
  	

  	# validate :at_least_one_name

	def at_least_one_name
	  if [self.image_ids, self.entry].reject(&:blank?).size == 0
    	errors.add :base, 'You need at least one field.'
	  end
	end
	# def self.default_scope
	# 	@entry = self.entry.find(params[:id])
	# 	order('@entry.entry_date DESC', 'created_at DESC')
	# end

	# def all_tags=(names)
	# 	self.tags = names.split(',').map do |name|
	# 		Tag.where(name: name.strip).first_or_create!
	# 	end
	# end

	# Add tags for new titles
	def add_tags(tag_names="")
		tag_names.split(',').map do |tag_name|
			if tag = user.tags.find_by(name: tag_name.strip)
				taggings.find_or_create_by(tag_id: tag.id, title_id: id)
			else
				tags.find_or_create_by(name: tag_name.strip, user_id: user_id)
			end
		end
	end


	def all_tags
		self.tags.map(&:name).join(", ")
	end

	def self.tagged_with(name)
		Tag.find_by_name!(name).titles
	end

	# Retrive all titles having with tag or child of this tag
	def self.childrens_of tag
	    title_ids = Tagging.where(tag_id: tag.subtree_ids).pluck(:title_id)

		Title.where(id: title_ids.uniq)
	end


	
end
