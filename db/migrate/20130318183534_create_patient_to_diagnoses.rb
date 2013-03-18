class CreatePatientToDiagnoses < ActiveRecord::Migration
  def change
    create_table :patient_to_diagnoses do |t|
      t.references :user
      t.references :diagnosis
      t.timestamps
    end

    add_foreign_key :patient_to_diagnoses, :users
    add_foreign_key :patient_to_diagnoses, :diagnoses

  end
end
