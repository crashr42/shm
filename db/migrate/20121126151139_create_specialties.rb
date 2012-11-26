class CreateSpecialties < ActiveRecord::Migration
  def change
    create_table :specialties do |t|
      t.string :name, :null => false
      t.timestamps
    end

    add_column :users, :specialty_id, :integer
    add_foreign_key :users, :specialties
    add_index :users, [:specialty_id]
  end
end
