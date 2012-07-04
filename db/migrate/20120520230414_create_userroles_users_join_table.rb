class CreateUserrolesUsersJoinTable < ActiveRecord::Migration
  def up
    create_table :userroles_users, :id => false do |t|
      t.integer :userrole_id
      t.integer :user_id
    end
  end

  def down
    drop_table :userroles_users
  end
end
