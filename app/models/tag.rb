class Tag < ActiveRecord::Base
	belongs_to :user
	has_many :taggings, :dependent => :destroy
	has_many :entries, -> { uniq }, through: :taggings

	validate :name_has_to_be_unique, on: :create

	default_scope { order('created_at DESC') } 
	validates_presence_of :name
	has_ancestry

	def self.counts
	  self.select("name, count(taggings.tag_id) as count").joins(:taggings).group("taggings.tag_id")
	end

	def self.hierarchy_tree
		self.arrange_serializable.to_json(:only => ["id","name", "children"])

	end


	private
	
	def name_has_to_be_unique
	   	unless self.user.tags.nil?
	   		if self.user.tags.where('lower(name) = ?', self.name.downcase).exists?
	   		errors.add(:name, "already exists")
	   		false
	   	end
	   	end
	end


end
