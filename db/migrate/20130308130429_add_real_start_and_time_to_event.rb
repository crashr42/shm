class AddRealStartAndTimeToEvent < ActiveRecord::Migration
  def up
    add_column :events, :real_start_time, :time
    add_column :events, :real_start_end, :time
  end

  def down
    remove_column :events, :real_start_time
    remove_column :events, :real_start_end
  end
end
