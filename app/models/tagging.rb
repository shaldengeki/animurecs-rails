class Tagging < ActiveRecord::Base
	belongs_to	:tag
	
	validates :show_id,	:presence => true,
						:numericality => true

	validates :tag_id,	:presence => true,
						:numericality => true

end
