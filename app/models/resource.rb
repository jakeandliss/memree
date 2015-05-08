class Resource < ActiveRecord::Base
  belongs_to :entry

  # Apply styling appropriate for this file
  has_attached_file :avatar, styles: lambda { |a| a.instance.check_file_type}, :default_url => "no_image.png"
  validates_attachment_content_type :avatar, :content_type => [
      /\Aaudio\/.*\Z/,
      /\Avideo\/.*\Z/, 
      /\Aimage\/.*\Z/, 
      "application/pdf", 
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
      "application/vnd.ms-excel",
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
      "application/msword",
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
      'text/plain'
    ] #See paperclip.rb initializer for all formats


  # IMPORTANT! The ffmpeg library has to added to the server machine. 
  # It can be uploaded from the official website https://www.ffmpeg.org/
  def check_file_type
    if is_image_type?
      {:large => "750x750>", :medium => "300x300#", :thumb => "100x100#" }
    elsif is_video_type?
      {
          :medium => { :geometry => "300x300#", :format => 'jpg', :time => 5},
          :video => {:geometry => "640x360#", :format => 'mp4', :processors => [:transcoder]}
      }
    elsif is_audio_type?
      {
        :audio => {
          :format => "mp3", :processors => [:transcoder]
        }
      }
     # avatar_file_name = self.basename(:avatar_file_name, self.extname(:avatar_file_name))
    elsif is_doc_type?
      {}
    else
      {}
    end
  end



  # Method returns true if file's content type contains word 'image', overwise false
  def is_image_type?
    avatar_content_type =~ %r(image)
  end

  # Method returns true if file's content type contains word 'video', overwise false
  def is_video_type?
    avatar_content_type =~ %r(video)
  end

  # Method returns true if file's content type contains word 'audio', overwise false
  def is_audio_type?
    avatar_content_type =~ /\Aaudio\/.*\Z/
  end

  def is_doc_type?
    avatar_content_type = ["application/pdf", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"]
  end


end
