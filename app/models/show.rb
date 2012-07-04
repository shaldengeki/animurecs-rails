class Show < ActiveRecord::Base
	belongs_to	:tag
	extend FriendlyId
	
	friendly_id :name, :use => :slugged

	has_attached_file :image, :styles => { :medium => "225x320>", :thumb => "100x142>" }
  
	validates_attachment_content_type :image, :content_type => ["image/jpeg", "image/png", "image/gif" ,"image/pjpeg","image/x-png"],
												:message => "Oops! Make sure you are uploading an image file."
									
	validates_attachment_size :image,  :less_than => 10.megabyte,
										:message => "Maximum show image size is 10M."  

	has_many	:comments,	:dependent => :destroy
	
	has_many	:taggings,	:foreign_key => "show_id",
							:dependent => :destroy
							
	has_many	:taggeds, 	:through => :taggings, 
							:source => "tag", 
							:dependent => :destroy
	
	has_many	:showvotes,	:dependent => :destroy
	
	validates :name, 	:presence => true,
						:uniqueness => { :case_sensitive => false }, 
						:length => { :within => 1..150 }
						
	validates :description, :presence => true,
							:length => { :within => 15..1600 }

	validates :length,	:presence => true,
						:length => { :within => 15..150 }
								
	validates :upvotes, :presence => true,
						:numericality => {:greater_than_or_equal_to => 0}

	validates :downvotes, 	:presence => true,
							:numericality => {:greater_than_or_equal_to => 0}
							
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
