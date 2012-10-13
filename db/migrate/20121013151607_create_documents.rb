class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|

      t.reference :event
      t.reference :created_by

      t.string :record
      t.datetime :created_at, :null => false

      t.timestamps
    end

    add_foreign_key :documents, :events
    add_foreign_key :documents, :users

    add_index :documents, [:event_id]
    add_index :documents, [:user_id]
  end
end
