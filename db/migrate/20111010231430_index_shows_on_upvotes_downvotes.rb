class IndexShowsOnUpvotesDownvotes < ActiveRecord::Migration
  def self.up
    add_index :shows, [:upvotes, :downvotes]
  end

  def self.down
    remove_index :shows, [:upvotes, :downvotes]
  end
end
