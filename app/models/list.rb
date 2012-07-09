class List < ActiveRecord::Base
  belongs_to :user
  has_many :list_entries
  # attr_accessible :title, :body
  validates :user_id, :presence => true

  def list_entries=(hash)
    hash.each do |sequence,list_entry|
      unless list_entry.nil? || list_entry.empty?
        new_entry = ListEntry.find_or_initialize_by_list_id_and_show_id(list_entry[:list_id], list_entry[:show_id])
        if can? :update, new_entry
          new_entry = list_entry
          new_entry.save!
        end
      end
    end
  end
end
