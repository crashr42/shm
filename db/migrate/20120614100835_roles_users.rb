class RolesUsers < ActiveRecord::Migration
  def up
    create_table :roles_users do |t|
      t.references :user
      t.references :role
    end

    add_foreign_key :roles_users, :users
    add_foreign_key :roles_users, :roles

    add_index :roles_users, [:user_id]
    add_index :roles_users, [:role_id]
  end

  def down
    drop_table :roles_users
  end
end
