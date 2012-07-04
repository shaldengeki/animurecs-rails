class ListEntry < ActiveRecord::Base
  belongs_to :list
  belongs_to :show
  attr_accessible :comment, :last_watched_at, :score, :show_id, :list_id

  validates :user, :presence => true
  validates :list, :presence => true
  validates :show, :presence => true

  validates :comment,	:presence => true,
            :allow_blank => true,
            :length => { :within => 0..1500 }

  validates_numericality_of :score, :only_integer => true, :message => "can only be whole number."
  validates_inclusion_of :score, :in => 0..10, :message => "can only be between 0 and 10."

  def user
    if list.nil?
      nil
    end
    list.user
  end
end
