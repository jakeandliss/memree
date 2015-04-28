class Tag < ActiveRecord::Base
	belongs_to :user
	has_many :taggings, :dependent => :destroy
	has_many :titles, -> { uniq }, through: :taggings
	default_scope { order('created_at DESC') } 
	validates_uniqueness_of :name

	def self.counts
	  self.select("name, count(taggings.tag_id) as count").joins(:taggings).group("taggings.tag_id")
	end
end
