class User < ActiveRecord::Base
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	has_many :entries, :dependent => :destroy
	has_many :entry_shareable
	has_many :shared_entries, through: :entry_shareable, source: :entry  do
		def active
			where("entry_shareables.is_hidden = ?", false)
		end
	end
	has_many :tags, :dependent => :destroy
	has_many :resources, :through => :entries
	has_many :taggings, dependent: :destroy
	has_many :groups, dependent: :destroy
	has_many :group_members, dependent: :destroy

	validates :first_name, :last_name, presence: true


	has_attached_file :avatar, :styles => { :medium => "300x300>", :avatar =>  "150x150#", :thumb => "100x100>" }, :default_url => "blank_avatar.png"
  	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/, reject_if: :blank


	def full_name
		first_name + " " + last_name
	end

	def used_space_in_megabytes
		resources.sum(:file_size).fdiv(1024*1024)
	end

	def gravatar_url
		stripped_email = email.strip 
		downcase_email = stripped_email.downcase
		hash = Digest::MD5.hexdigest(downcase_email)

		"http://gravatar.com/avatar/#{hash}"
	end

  def invitee?
    !encrypted_password.present?
  end

  def associated_members
    members = []
    groups.map {|g| members += g.members }
    members.uniq!
  end

end

