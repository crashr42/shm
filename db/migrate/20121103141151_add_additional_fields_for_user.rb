class AddAdditionalFieldsForUser < ActiveRecord::Migration
  def up
    add_column :users, :first_name, :string, :null => false
    add_column :users, :last_name,  :string, :null => false
    add_column :users, :third_name, :string
    add_column :users, :address,    :string, :null => false
    add_column :users, :policy,     :string, :null => true
    
    add_column :bids, :email, :string, :null => false
  end

  def down
  end
end
