class CreateAppointmentDocumentInfos < ActiveRecord::Migration
  def change
    
    remove_column :documents, :record
    add_column :documents, :type, :string

    create_table :appointment_document_infos do |t|
      t.text :anamnesis
      t.text :appointment_result
      t.integer :document_id
      
      t.timestamps
    end
  end
end
