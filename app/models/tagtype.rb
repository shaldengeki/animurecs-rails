class Tagtype < ActiveRecord::Base
	has_many	:tags
	
	validates :name,	:presence => true,
						:uniqueness => { :case_sensitive => false }, 
						:length => { :within => 1..150 }
	validates :color,	:presence => true,
						:length => { :within => 1..150 }
end
