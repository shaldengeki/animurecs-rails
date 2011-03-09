class Tagging < ActiveRecord::Base
	belongs_to	:tag
	
	validates :series_id,	:presence => true,
							:numericality => true

	validates :tag_id,	:presence => true,
						:numericality => true

end
