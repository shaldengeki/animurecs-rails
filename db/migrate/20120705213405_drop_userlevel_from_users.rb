class DropUserlevelFromUsers < ActiveRecord::Migration
  change_table :users do |t|
    t.remove :userlevel
  end
end
