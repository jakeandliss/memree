class Entry < ActiveRecord::Base
  belongs_to :title
  
  has_many :images, as: :imageable
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "no_image.png"
  

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  default_scope { order('entry_date DESC', 'created_at DESC') } 
  validate :at_least_one_name

	def at_least_one_name
	  if [self.image_ids, self.entry].reject(&:blank?).size == 0
    	errors.add :base, 'You need at least one field.'
	  end
	end
end	