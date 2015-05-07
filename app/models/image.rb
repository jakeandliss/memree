class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  #has_attached_file :avatar, styles: {:large => "750x750>", :medium => "300x300#", :thumb => "100x100#" }, :default_url => "no_image.png"

  #has_attached_file :avatar
  	# if: :is_video_type?, :styles =>  {
	  #   :medium => { :geometry => "640x480", :format => 'flv' },
	  #   :thumb => { :geometry => "100x100#", :format => 'jpg', :time => 10 }
	  # }, :processors => [:transcoder]


  has_attached_file :avatar, styles: lambda { |a| a.instance.check_file_type}, :default_url => "no_image.png"


  validates_attachment_content_type :avatar, :content_type => /.*/


  def check_file_type
    if is_image_type?
      {:large => "750x750>", :medium => "300x300#", :thumb => "100x100#" }
    elsif is_video_type?
      {
          :medium => { 
            :geometry => "300x300#", 
            :format => 'jpg', 
          },
          :video => {:geometry => "640x360#", :format => 'mp4', :processors => [:transcoder]
          }
      }
    elsif is_audio_type?
      {
        :audio => {
          :format => "mp3", :processors => [:transcoder]
        }
      }
     # avatar_file_name = self.basename(:avatar_file_name, self.extname(:avatar_file_name))
    else
      {}
    end
  end

  def is_image_type?
    avatar_content_type =~ %r(image)
  end

  def is_video_type?
    avatar_content_type =~ %r(video)
  end

  def is_audio_type?
    avatar_content_type =~ /\Aaudio\/.*\Z/
  end


end



# class Image < ActiveRecord::Base
#   belongs_to :imageable, polymorphic: true

#   has_attached_file :avatar, styles: lambda { |a| a.instance.check_file_type}, :default_url => "no_image.png"


#   validates_attachment_content_type :avatar,
#     :content_type => ['image/png', 'image/jpeg', 'image/jpg', 'image/gif'],
#  	:if => :is_image_type? 
#   validates_attachment_content_type :avatar,
#     :content_type => ['video/m4v', 'video/mp4'],
#     :if => :is_video_type? 

#   def check_file_type 
# 	if is_image_type? 
# 		{:large => "750x750>", :medium => "300x300#", :thumb => "100x100#" }
#  	elsif is_video_type? 
#  		{ :thumb => { :geometry => "100x100#", :format => 'jpg', :time => 10, :processors => [:ffmpeg] }, :medium => {:geometry => "250x150#", :format => 'jpg', :time => 10, :processors => [:ffmpeg]} } 
# 	else {} 
# 	end 
#   end

#   def is_image_type? 
# 	@content_type =~ %r(video)
# 	# /\Aimage\/.*\Z/
#   end 

#   def is_video_type? 
#   	@content_type =~ %r(video)
#   end

# end


