class CreateParameters < ActiveRecord::Migration
  def change
    create_table :parameters do |t|
      t.string      :name,     :null => false
      t.string      :type,     :null => false
      t.text        :metadata, :null => false
      t.timestamps
    end
  end
end
