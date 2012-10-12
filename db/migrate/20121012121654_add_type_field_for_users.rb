class AddTypeFieldForUsers < ActiveRecord::Migration
  def up
    add_column :users, :type, :string, :null => true
    User.all.each do |u|
      u.type = "#{u.roles.first.name.capitalize!}User"
      u.save!
    end
    change_column :users, :type, :string, :null => false
  end

  def down
    remove_column :users, :type
  end
end
