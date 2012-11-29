class AddDurationForEvent < ActiveRecord::Migration
  def up
    change_column :events, :status, :string, :null => false, :default => 'free'
    add_column :events, :duration, :integer
    add_column :events, :event_id, :integer, :null => true

    add_foreign_key :events, :events
  end

  def down
  end
end
