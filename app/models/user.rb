class User < ActiveRecord::Base
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :titles

	has_attached_file :avatar, :styles => { :medium => "300x300>", :avatar =>  "150x150#", :thumb => "100x100>" }, :default_url => "blank_avatar.png"
  	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/, reject_if: :blank


	def full_name
		first_name + " " + last_name
	end

	def gravatar_url
		stripped_email = email.strip 
		downcase_email = stripped_email.downcase
		hash = Digest::MD5.hexdigest(downcase_email)

		"http://gravatar.com/avatar/#{hash}"
	end

end

