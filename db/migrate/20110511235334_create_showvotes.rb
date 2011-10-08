class CreateShowvotes < ActiveRecord::Migration
  def self.up
    create_table :showvotes do |t|
      t.integer :show_id
      t.integer :user_id
      t.integer :vote

      t.timestamps
    end
      add_index :showvotes, :user_id
      add_index :showvotes, :show_id
  end

  def self.down
    drop_table :showvotes
  end
end
