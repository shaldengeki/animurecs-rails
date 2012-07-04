class Showvote < ActiveRecord::Base
	belongs_to	:show
	belongs_to	:user
		
	validates :show_id,	:presence => true,
						:numericality => true
	
	validates :user_id,	:presence => true,
						:numericality => true
	
	validates :vote,	:presence => true
	validates_numericality_of :vote, :only_integer => true, :message => "can only be whole number."
	validates_inclusion_of :vote, :in => -1..1, :message => "can only be between -1 and 1."
end
