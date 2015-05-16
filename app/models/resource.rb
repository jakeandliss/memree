class Resource < ActiveRecord::Base
  belongs_to :entry



  # Apply styling appropriate for this file
  has_attached_file :avatar, 
    styles: lambda { |a| a.instance.check_file_type}, 
    default_url: "no_image.png", 
    processors: lambda { |a| a.processors},
    only_process: lambda { |b| b.instance.process_in_foreground}

  # # Don't forget to add name of the image that will be shown while the file is loading
  #process_in_background :avatar, only_process: [:original], processing_image_url: lambda { |a| a.instance.processing_image_path("vid-processing.jpg")}


  def process_in_foreground
    [:medium, :original]
  end

  def process_in_background_c
     is_video_type? ? :original : ""
  end




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


  def processors
    if is_image_type?
      [:thumbnail, :compression]
    elsif is_video_type?
      [:transcoder]
    end
  end

  # IMPORTANT! The ffmpeg library has to added to the server machine. 
  # It can be uploaded from the official website https://www.ffmpeg.org/
  def check_file_type
    if is_image_type?
      {
        :original => "750x750>"
      }
    elsif is_video_type?
      {
        :medium => { :geometry => "300x300#", :format => 'jpg', :time => 5},
        :original => {:geometry => "1024x576>", :format => 'mp4'}
      }
    elsif is_doc_type?
      {}
    else
      {}
    end
  end

  # The path of the image that will be shown while the file is loading
  def processing_image_path(image_name)
    "/assets/" + Rails.application.assets.find_asset(image_name).digest_path
  end  


  
  
  # Method returns true if file's content type contains word 'image', overwise false
  def is_image_type?
    avatar_content_type ? avatar_content_type =~ %r(image) : false
  end

  # Method returns true if file's content type contains word 'video', overwise false
  def is_video_type?
    avatar_content_type ? avatar_content_type =~ %r(video) : false
  end

  # Method returns true if file's content type contains word 'audio', overwise false
  def is_audio_type?
    avatar_content_type ? avatar_content_type =~ /\Aaudio\/.*\Z/ : false
  end

  def is_doc_type?
    avatar_content_type = ["application/pdf", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"]
  end


end
