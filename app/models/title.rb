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

	def all_tags=(names)
		self.tags = names.split(',').map do |name|
			Tag.where(name: name.strip).first_or_create!
		end
	end

	def all_tags
		self.tags.map(&:name).join(", ")
	end

	def self.tagged_with(id)
		Tag.find_by_id!(id).titles
	end


	
end
