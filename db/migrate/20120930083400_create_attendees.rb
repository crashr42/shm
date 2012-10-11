class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.references :event
      t.references :user
      t.string     :role
      t.timestamps
    end

    add_foreign_key :attendees, :events
    add_foreign_key :attendees, :users

    add_index :attendees, [:event_id]
    add_index :attendees, [:user_id]
  end
end
