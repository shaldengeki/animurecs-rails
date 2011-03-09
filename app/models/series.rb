class Series < ActiveRecord::Base
	belongs_to 	:genre
	has_many	:comments
	has_many	:taggings, :through => :taggings, :source => "show_id"
end
