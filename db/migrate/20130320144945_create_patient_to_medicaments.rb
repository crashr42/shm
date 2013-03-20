class CreatePatientToMedicaments < ActiveRecord::Migration
  def change
    create_table :patient_to_medicaments do |t|
      t.references :users
      t.references :medicaments
      t.timestamps
    end
  end
end
