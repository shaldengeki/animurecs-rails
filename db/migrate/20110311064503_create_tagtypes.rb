class CreateTagtypes < ActiveRecord::Migration
  def self.up
    create_table :tagtypes do |t|
      t.string :name
      t.string :color

      t.timestamps
    end
  end

  def self.down
    drop_table :tagtypes
  end
end
