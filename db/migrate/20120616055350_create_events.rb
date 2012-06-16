class CreateEvents < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.references :calendar

      t.datetime  :dtstart,     :null => false, :default => DateTime.now
      t.string    :description
      t.string    :status,      :null => false, :default => 'CONFIRMED'
      t.string    :summary,     :null => false

      t.timestamps
    end

    add_foreign_key :events, :calendars
    add_index :events, [:calendar_id]
  end

  def down
    drop_table :events
  end
end
