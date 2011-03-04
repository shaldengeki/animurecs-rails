class Genre < ActiveRecord::Base
	has_many :series
end
