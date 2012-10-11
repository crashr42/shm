class CreateRecurrenceRules < ActiveRecord::Migration
  def up
    create_table :recurrence_rules do |t|
      t.references :event

      t.string    :frequency, :null => false
      t.integer   :count
      t.datetime  :end_date
      t.integer   :interval

      t.string  :seconds                                          # byseclist
      t.string  :minutes                                          # byminlist
      t.string  :hours                                            # byhrlist
      t.string  :week_days                                        # bywdaylist
      t.string  :month_days                                       # bymodaylist
      t.string  :year_days                                        # byyrdaylist
      t.string  :weeks                                            # bywknolist
      t.string  :months                                           # bymolist
      t.string  :position                                         # bysplist
      t.string  :week_start, :null => false, :default => 'monday' # wkst

      t.integer :fact_count
      t.boolean :active

      t.timestamps
    end

    add_foreign_key :recurrence_rules, :events
    add_index :recurrence_rules, [:event_id]
  end

  def down
    drop_table :recurrence_rules
  end
end
