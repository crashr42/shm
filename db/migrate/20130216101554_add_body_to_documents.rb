class AddBodyToDocuments < ActiveRecord::Migration
  def up
    change_table :documents do |t|
      t.text :body
    end
  end

  def down
    remove_column :documents, :body
  end
end
