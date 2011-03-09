class Comment < ActiveRecord::Base
	belongs_to	:user
	validates :text,	:presence => true,
						:length => { :within => 15..1500 }
						
	validates :series_id,	:presence => true,
							:numericality => true
							
	validates :user_id,	:presence => true,
						:numericality => true
						
	validates :time, 	:presence => true,
						:numericality => true
end
