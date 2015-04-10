class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  has_attached_file :avatar, :styles => { :large => "750x750>", :medium => "300x300#", :thumb => "100x100#" }, :default_url => "no_image.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
end
