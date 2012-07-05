class ShowAlias < ActiveRecord::Base
  belongs_to :show
  attr_accessible :name, :show_id

  validates :name, :presence => true
  validates :show_id, :presence => true
end
