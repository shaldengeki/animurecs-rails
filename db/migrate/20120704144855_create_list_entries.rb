class CreateListEntries < ActiveRecord::Migration
  def change
    create_table :list_entries do |t|
      t.references :list
      t.references :show
      t.integer :score
      t.timestamp :last_watched_at
      t.string :comments

      t.timestamps
    end
    add_index :list_entries, :list_id
    add_index :list_entries, :show_id
  end
end
