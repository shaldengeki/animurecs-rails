class CreateUserroles < ActiveRecord::Migration
  def change
    create_table :userroles do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
