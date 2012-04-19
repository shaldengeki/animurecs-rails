class AddSlugToUsersShowsTags < ActiveRecord::Migration
  def up
    add_column :users, :slug, :string
    add_index :users, :slug, unique: true
	
    add_column :shows, :slug, :string
    add_index :shows, :slug, unique: true
	
    add_column :tags, :slug, :string
    add_index :tags, :slug, unique: true
  end
  def down
    remove_index :users, :slug
    remove_column :users, :slug
	
    remove_index :shows, :slug
    remove_column :shows, :slug
	
    remove_index :tags, :slug
    remove_column :tags, :slug
  end
end

