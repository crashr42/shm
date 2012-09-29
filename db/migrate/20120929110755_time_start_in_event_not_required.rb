class TimeStartInEventNotRequired < ActiveRecord::Migration
  def up
    change_table :events do |t|
      t.change :time_start, :time, :null => true
    end
  end

  def down
  end
end
