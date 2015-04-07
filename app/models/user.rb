class User < ActiveRecord::Base
	has_many :titles

	has_secure_password

	validates :email, presence: true, 
                  uniqueness: true,
                  format: {
                    with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9\.-]+\.[A-Za-z]+\Z/
                  }

	before_save :downcase_email

	has_attached_file :avatar, :styles => { :medium => "300x300>", :avatar =>  "150x150#", :thumb => "100x100>" }, :default_url => "blank_avatar.png"
  	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/, reject_if: :blank
	
	def downcase_email 
		self.email = email.downcase
	end

	def generate_password_reset_token! 
		update_attribute(:password_reset_token, SecureRandom.urlsafe_base64(48))
	end

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

