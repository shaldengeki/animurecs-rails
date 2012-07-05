class CreateShowAliases < ActiveRecord::Migration
  def change
    create_table :show_aliases do |t|
      t.string :name
      t.references :show

      t.timestamps
    end
    add_index :show_aliases, :show_id
  end
end
