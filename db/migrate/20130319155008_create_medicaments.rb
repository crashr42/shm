class CreateMedicaments < ActiveRecord::Migration
  def change
    create_table :medicaments do |t|
      t.string :reg_num
      t.string :med_type
      t.string :commercial_name
      t.string :producer
      t.string :atx_class
      t.string :form_factor

      t.timestamps
    end
  end
end
