class FixSeriesName < ActiveRecord::Migration
  def self.up
	rename_column :taggings, :series_id, :show_id
	rename_column :comments, :series_id, :show_id
  end

  def self.down
	rename_column :taggings, :show_id, :series_id
	rename_column :comments, :show_id, :series_id
  end
end
