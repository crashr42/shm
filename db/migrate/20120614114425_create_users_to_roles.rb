class CreateUsersToRoles < ActiveRecord::Migration
  def up
    create_table :users_to_roles do |t|
      t.references :user
      t.references :role
      t.timestamps
    end

    add_foreign_key :users_to_roles, :users
    add_foreign_key :users_to_roles, :roles

    add_index :users_to_roles, [:user_id]
    add_index :users_to_roles, [:role_id]
  end

  def down
    drop_table :users_to_roles
  end
end
