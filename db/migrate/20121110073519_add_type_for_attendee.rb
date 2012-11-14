class AddTypeForAttendee < ActiveRecord::Migration
  def up
    add_column :attendees, :type, :string, :null => false
    remove_column :attendees, :role
  end

  def down
    remove_column :attendees, :type
  end
end
