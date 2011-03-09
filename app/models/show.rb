class Show < ActiveRecord::Base
	has_many	:comments
	has_many	:taggings, :through => :taggings, :source => "show_id"
end
