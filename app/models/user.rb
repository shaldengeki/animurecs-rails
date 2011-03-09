class User < ActiveRecord::Base
	attr_accessible :username, :password, :color, :userlevel
	has_many :comments

	validates :username,	:presence => true,
							:length   => { :maximum => 50 },
							:uniqueness => { :case_sensitive => false }

	validates :userlevel,	:presence => true,
							:numericality => true
end
