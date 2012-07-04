class RenameListEntryCommentsToComment < ActiveRecord::Migration
  change_table :list_entries do |t|
    t.rename :comments, :comment
  end
end
