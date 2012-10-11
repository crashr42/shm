class CreateCalendars < ActiveRecord::Migration
  def up
    create_table :calendars do |t|
      t.references :user

      t.string  :name,        :null => false
      t.text    :description

      t.timestamps
    end

    add_foreign_key :calendars, :users
    add_index :calendars, [:user_id]
  end

  def down
    drop_table :calendars
  end
end
