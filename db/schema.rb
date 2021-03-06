# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120705213405) do

  create_table "comments", :force => true do |t|
    t.string   "text",       :limit => 1500
    t.integer  "show_id"
    t.integer  "user_id"
    t.integer  "time"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "genres", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "list_entries", :force => true do |t|
    t.integer  "list_id"
    t.integer  "show_id"
    t.integer  "score"
    t.datetime "last_watched_at"
    t.string   "comment"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "list_entries", ["list_id"], :name => "index_list_entries_on_list_id"
  add_index "list_entries", ["show_id"], :name => "index_list_entries_on_show_id"

  create_table "lists", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "lists", ["user_id"], :name => "index_lists_on_user_id"

  create_table "series", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "link"
    t.integer  "genre_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "show_aliases", :force => true do |t|
    t.string   "name"
    t.integer  "show_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "show_aliases", ["show_id"], :name => "index_show_aliases_on_show_id"

  create_table "shows", :force => true do |t|
    t.string   "name"
    t.text     "description",        :limit => 2147483647
    t.string   "length"
    t.integer  "upvotes"
    t.integer  "downvotes"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "slug"
  end

  add_index "shows", ["name"], :name => "index_shows_on_name", :unique => true
  add_index "shows", ["slug"], :name => "index_shows_on_slug", :unique => true
  add_index "shows", ["upvotes", "downvotes"], :name => "index_shows_on_upvotes_and_downvotes"

  create_table "showvotes", :force => true do |t|
    t.integer  "show_id"
    t.integer  "user_id"
    t.integer  "vote"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "showvotes", ["show_id"], :name => "index_showvotes_on_show_id"
  add_index "showvotes", ["user_id"], :name => "index_showvotes_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "show_id"
    t.integer  "tag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "taggings", ["show_id"], :name => "index_taggings_on_show_id"
  add_index "taggings", ["tag_id", "show_id"], :name => "index_taggings_on_tag_id_and_show_id", :unique => true

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "tagtype_id"
    t.string   "slug"
  end

  add_index "tags", ["name"], :name => "index_tags_on_name", :unique => true
  add_index "tags", ["slug"], :name => "index_tags_on_slug", :unique => true

  create_table "tagtypes", :force => true do |t|
    t.string   "name"
    t.string   "color"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "userroles", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "userroles_users", :id => false, :force => true do |t|
    t.integer "userrole_id"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "color"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "password_digest"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "slug"
    t.integer  "age"
    t.text     "gender"
    t.text     "description"
    t.string   "remember_token"
  end

  add_index "users", ["gender"], :name => "index_users_on_gender", :length => {"gender"=>5}
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["slug"], :name => "index_users_on_slug", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
