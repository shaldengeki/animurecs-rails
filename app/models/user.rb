class User < ActiveRecord::Base
	attr_accessible :username, :password, :color, :userlevel

	validates :username,	:presence => true,
							:length   => { :maximum => 50 },
							:uniqueness => { :case_sensitive => false }

	has_many :comments
end
