class User < ActiveRecord::Base
  has_many :comments
  has_many	:showvotes,	:dependent => :destroy
  has_many :lists
  has_many :list_entries, :through => :lists
  has_and_belongs_to_many :userroles
  has_attached_file :avatar, :styles => { :medium => "225x320>", :thumb => "100x142>", :tiny => "25x25>" }
  has_secure_password
  before_save :create_remember_token
  accepts_nested_attributes_for :lists, :allow_destroy => true
  # before_save :encrypt_password, :unless => Proc.new { |u| u.password.blank? }

  attr_accessible :username, :age, :gender, :description, :color, :userlevel, :password, :password_confirmation, :avatar
	extend FriendlyId
	
	friendly_id :username, :use => :slugged

	validates :username,	:presence => true,
            :length   => { :maximum => 50 },
            :format => {:with => /^[a-z0-9\ ]+[-a-z0-9\ ]*[a-z0-9\ ]+$/i},
            :uniqueness => { :case_sensitive => false }

  validates :age, :numericality => true, :allow_nil => true, :allow_blank => true
  validates_inclusion_of :age, :in => 1..150, :message => "can only be between 1 and 150.", :allow_nil => true, :allow_blank => true

  validates :gender, :length => {:maximum => 10}

  validates :description, :length => {:maximum => 140}

	# Automatically create the virtual attribute 'password_confirmation'.
	validates :password, 	:presence     => true,
            :confirmation => true,
            :length       => { :minimum => 6 },
            :on           => :create,
            :if => :validate_password?

	validates :userlevel,	:presence => true,
            :numericality => true

  validates_inclusion_of :userlevel, :in => 0..5, :message => "can only be between 0 and 5."

	validates_attachment_content_type :avatar, :content_type => %w(image/jpeg image/png image/gif image/pjpeg image/x-png),
                                    :message => "Oops! Make sure you are uploading an image file."
									
	validates_attachment_size :avatar,  :less_than => 10.megabyte,
                            :message => "Maximum avatar size is 10M."
  def has_role?(role_sym)
    userroles.any? { |r| r.name.underscore.to_sym == role_sym }
  end
  def validate_password?
    password.present? || password_confirmation.present?
  end
  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end