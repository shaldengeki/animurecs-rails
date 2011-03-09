class CreateShows < ActiveRecord::Migration
  def self.up
    create_table :shows do |t|
      t.string :name
      t.string :description
      t.string :length
      t.string :link
      t.integer :upvotes
      t.integer :downvotes

      t.timestamps
    end
  end

  def self.down
    drop_table :shows
  end
end
