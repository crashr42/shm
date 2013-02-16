class DelAppointmentDocumentInfos < ActiveRecord::Migration
  #This name therefore migration_name is very long name for Ruby Class

  def up
    drop_table :appointment_document_infos
  end

  def down
    create_table :documents do |t|

      t.references :event
      t.references :user

      t.string :record

      t.timestamps
    end

    add_foreign_key :documents, :events
    add_foreign_key :documents, :users

    add_index :documents, [:event_id]
    add_index :documents, [:user_id]
  end
end
