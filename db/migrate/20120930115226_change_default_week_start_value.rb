class ChangeDefaultWeekStartValue < ActiveRecord::Migration
  def up
    remove_column :recurrence_rules, :week_start
    add_column :recurrence_rules, :week_start, :integer, :null => false, :default => 1
  end

  def down
  end
end
