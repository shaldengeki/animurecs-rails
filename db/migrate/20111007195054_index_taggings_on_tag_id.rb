class IndexTaggingsOnTagId < ActiveRecord::Migration
  def self.up
	add_index :taggings, :tag_id
  end

  def self.down
	remove_index :taggings, :tag_id
  end
end
