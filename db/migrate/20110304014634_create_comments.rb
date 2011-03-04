class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :text
      t.integer :series_id
      t.integer :user_id
      t.integer :time

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
