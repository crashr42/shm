class CreateCalendars < ActiveRecord::Migration
  def up
    create_table :calendars do |t|
      t.references :user

      t.string  :name,        :null => false
      t.text    :description

      t.timestamps
    end
  end

  def down
    drop_table :calendars
  end
end
