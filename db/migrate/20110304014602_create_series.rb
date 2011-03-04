class CreateSeries < ActiveRecord::Migration
  def self.up
    create_table :series do |t|
      t.string :name
      t.string :description
      t.string :link
      t.integer :genre_id

      t.timestamps
    end
  end

  def self.down
    drop_table :series
  end
end
