class Tag < ActiveRecord::Base
	has_many	:taggings
	belongs_to	:tagtype
  	extend FriendlyId
	
	friendly_id :name, :use => :slugged
	validates :name, 	:presence => true,
						:uniqueness => { :case_sensitive => false }, 
						:length => { :within => 1..150 }
	
	validates :tagtype_id,	:presence => true, 
							:numericality => true
end