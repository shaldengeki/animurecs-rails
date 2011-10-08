class User < ActiveRecord::Base
	attr_accessible :username, :color, :userlevel, :password, :password_confirmation, :avatar
	attr_accessor :password

	has_many :comments
	has_many	:showvotes,	:dependent => :destroy

	validates :username,	:presence => true,
							:length   => { :maximum => 50 },
							:uniqueness => { :case_sensitive => false }
							
	# Automatically create the virtual attribute 'password_confirmation'.
	validates :password, 	:presence     => true,
							:confirmation => true,
							:length       => { :within => 6..40 }
							
	validates :userlevel,	:presence => true,
							:numericality => true

	before_save :encrypt_password

	has_attached_file :avatar, :styles => { :medium => "225x320>", :thumb => "100x142>" }

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
