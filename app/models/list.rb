class List < ActiveRecord::Base
  belongs_to :user
  has_many :list_entries
  # attr_accessible :title, :body
  validates :user_id, :presence => true
end
