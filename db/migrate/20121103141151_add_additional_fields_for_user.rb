class AddAdditionalFieldsForUser < ActiveRecord::Migration
  def up
    add_column :users, :first_name, :string
    add_column :users, :last_name,  :string
    add_column :users, :third_name, :string
    add_column :users, :address,    :string
    add_column :users, :policy,     :string
    
    add_column :bids, :email, :string
  end

  def down
  end
end
