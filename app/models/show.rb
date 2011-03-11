class Show < ActiveRecord::Base
	belongs_to	:tag

	has_attached_file :image, :styles => { :medium => "225x320>", :thumb => "100x142>" }

	has_many	:comments,	:dependent => :destroy
	
	has_many	:taggings,	:foreign_key => "show_id",
							:dependent => :destroy
							
	has_many	:taggeds, 	:through => :taggings, 
							:source => "tag", 
							:dependent => :destroy
	
	validates :name, 	:presence => true,
						:uniqueness => { :case_sensitive => false }, 
						:length => { :within => 1..150 }
						
	validates :description, :presence => true,
							:length => { :within => 15..1500 }

	validates :length,	:presence => true,
						:length => { :within => 15..150 }
								
	validates :link, :presence => true,
					:length => { :within => 5..1500 }
								
	validates :upvotes, :presence => true,
						:numericality => true

	validates :downvotes, 	:presence => true,
							:numericality => true

							
	def tagging?(tagged)
		taggings.find_by_tag_id(tagged)
	end

	def tag!(tagged)
		taggings.create!(:tag_id => tagged.id)
	end
	
	def untag!(tagged)
		taggings.find_by_tag_id(tagged).destroy
	end

end
