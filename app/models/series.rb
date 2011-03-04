class Series < ActiveRecord::Base
	belongs_to 	:genre
	has_many	:comments
end
