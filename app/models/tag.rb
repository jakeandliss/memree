class Tag < ActiveRecord::Base
	belongs_to :user
	has_many :taggings, :dependent => :destroy
	has_many :entries, -> { uniq }, through: :taggings
	before_create :change_registry
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

	def change_registry
		self.name = self.name.downcase
	end


end
