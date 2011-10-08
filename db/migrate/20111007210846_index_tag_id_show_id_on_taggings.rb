class IndexTagIdShowIdOnTaggings < ActiveRecord::Migration
  def self.up
	remove_index :taggings, :tag_id
	add_index :taggings, [:tag_id, :show_id], :unique => true
  end

  def self.down
	remove_index :taggings, [:tag_id, :show_id]
	add_index :taggings, :tag_id
  end
end
