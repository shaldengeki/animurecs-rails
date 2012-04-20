class AddAgeGenderAndDescriptionToUsers < ActiveRecord::Migration
  def up
    add_column :users, :age, :int
    add_column :users, :gender, :text
    add_column :users, :description, :text
    add_index :users, :gender, :length => {:gender => 5}
  end
  def down
    remove_index :users, :gender
    remove_column :users, :age
    remove_column :users, :gender
    remove_column :users, :description
  end
end
