class DropLinkFromShows < ActiveRecord::Migration
  change_table :shows do |t|
    t.remove :link
  end
end
