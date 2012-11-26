class CreateDiagnoses < ActiveRecord::Migration
  def change
    create_table :diagnoses do |t|
      t.string :class_code, :null => false
      t.string :class_name, :null => false
      t.string :block_code, :null => false
      t.string :block_name, :null => false
      t.string :code,       :null => false
      t.string :code_name,  :null => false
      t.timestamps
    end

    add_column :users, :diagnosis_id, :integer
    add_foreign_key :users, :diagnoses
    add_index :users, [:diagnosis_id]
  end
end
