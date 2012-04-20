class User < ActiveRecord::Base
	attr_accessible :username, :age, :gender, :description, :color, :userlevel, :password, :password_confirmation, :avatar
	attr_accessor :password
	extend FriendlyId
	
	friendly_id :username, :use => :slugged

	has_many :comments
	has_many	:showvotes,	:dependent => :destroy

	validates :username,	:presence => true,
							:length   => { :maximum => 50 },
							:format => {:with => /^[a-z0-9\ ]+[-a-z0-9\ ]*[a-z0-9\ ]+$/i},
							:uniqueness => { :case_sensitive => false }

  validates :age, :numericality => true

  validates :description, :length => {:maximum => 140}

	# Automatically create the virtual attribute 'password_confirmation'.
	validates :password, 	:presence     => true,
							:confirmation => true,
							:length       => { :within => 6..40 }, 
							:on           => :create
							
	validates :userlevel,	:presence => true,
							:numericality => true

	before_save :encrypt_password, :unless => Proc.new { |u| u.password.blank? }

	has_attached_file :avatar, :styles => { :medium => "225x320>", :thumb => "100x142>", :tiny => "25x25>" }
  
	validates_attachment_content_type :avatar, :content_type => ["image/jpeg", "image/png", "image/gif" ,"image/pjpeg","image/x-png"],
												:message => "Oops! Make sure you are uploading an image file."
									
	validates_attachment_size :avatar,  :less_than => 10.megabyte,
										:message => "Maximum avatar size is 10M."

	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)
	end

	def self.authenticate(username, submitted_password)
		user = find_by_username(username)
		return nil  if user.nil?
		return user if user.has_password?(submitted_password)
	end
	def self.authenticate_with_salt(id, cookie_salt)
		user = find_by_id(id)
		(user && user.salt == cookie_salt) ? user : nil
	end

	private

	def encrypt_password
		self.salt = make_salt if new_record?
		self.encrypted_password = encrypt(password)
	end

	def encrypt(string)
		secure_hash("#{salt}--#{string}")
	end

	def make_salt
		secure_hash("#{Time.now.utc}--#{password}")
	end

	def secure_hash(string)
		Digest::SHA256.hexdigest(string)
	end
end
