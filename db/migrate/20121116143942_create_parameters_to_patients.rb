class CreateParametersToPatients < ActiveRecord::Migration
  def change
    create_table :parameters_to_patients do |t|
      t.references :user
      t.references :parameter
      t.timestamps
    end

    add_foreign_key :parameters_to_patients, :users
    add_foreign_key :parameters_to_patients, :parameters
  end
end
