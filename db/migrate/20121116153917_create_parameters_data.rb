class CreateParametersData < ActiveRecord::Migration
  def change
    create_table :parameters_data do |t|
      t.references :user
      t.references :parameter
      t.string     :value
      t.timestamps
    end

    add_foreign_key :parameters_data, :users
    add_foreign_key :parameters_data, :parameters
  end
end
