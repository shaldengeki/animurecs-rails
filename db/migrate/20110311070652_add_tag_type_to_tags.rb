class AddTagTypeToTags < ActiveRecord::Migration
  def self.up
    add_column :tags, :tagtype_id, :integer
  end

  def self.down
    remove_column :tags, :tagtype_id
  end
end
