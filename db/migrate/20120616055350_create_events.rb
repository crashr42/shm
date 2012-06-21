class CreateEvents < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.references :calendar
      t.references :user        # organizer

      t.date      :date_start,  :null => false
      t.time      :time_start,  :null => false
      t.string    :description
      t.string    :status,      :null => false, :default => 'CONFIRMED'
      t.string    :summary,     :null => false
      t.date      :date_end
      t.time      :time_end

      t.timestamps
    end

    add_foreign_key :events, :calendars
    add_index :events, [:calendar_id]

    add_foreign_key :events, :users
    add_index :events, [:user_id]
  end

  def down
    drop_table :events
  end
end
