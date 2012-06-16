class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :calendar

      t.datetime  :dtstart,     :null => false, :default => DateTime.now
      t.string    :description
      t.string    :status,      :null => false, :default => 'CONFIRMED'
      t.string    :summary,     :null => false

      t.timestamps
    end
  end
end
