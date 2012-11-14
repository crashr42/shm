class RemoveTimeColumnFromEvents < ActiveRecord::Migration
  def up
    remove_column :events, :time_start
    remove_column :events, :time_end
    change_column :events, :date_start, :datetime
    change_column :events, :date_end, :datetime
  end

  def down
  end
end
