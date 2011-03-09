class Tag < ActiveRecord::Base
	has_many	:taggings
  
	validates :name, 	:presence => true,
						:uniqueness => { :case_sensitive => false }, 
						:length => { :within => 1..150 }
						
	validates :description, :presence => true,
							:length => { :within => 15..1500 }
end
