class ChangeShowDescriptionToLongText < ActiveRecord::Migration
  def self.up
	change_column :shows, :description, :longtext
  end

  def self.down
	change_column :shows, :description, :string
  end
end
