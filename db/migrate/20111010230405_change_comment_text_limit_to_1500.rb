class ChangeCommentTextLimitTo1500 < ActiveRecord::Migration
  def self.up
    change_column :comments, :text, :string, :limit => 1500
  end

  def self.down
    change_column :comments, :text, :string, :limit => 255
  end
end
