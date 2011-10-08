class IndexTaggingsOnShowId < ActiveRecord::Migration
  def self.up
	add_index :taggings, :show_id
  end

  def self.down
	remove_index :taggings, :show_id
  end
end
