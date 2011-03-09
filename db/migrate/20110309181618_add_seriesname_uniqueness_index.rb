class AddSeriesnameUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :shows, :name, :unique => true
  end

  def self.down
    remove_index :shows, :name
  end
end
