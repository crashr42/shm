class AddTypeFieldForEvents < ActiveRecord::Migration
  def up
    add_column :events, :type, :string, :null => false
  end

  def down
  end
end
