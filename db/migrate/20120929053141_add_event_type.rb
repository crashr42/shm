class AddEventType < ActiveRecord::Migration
  def up
    add_column :events, :category, :string
  end

  def down
    remove_column :events, :category
  end
end
