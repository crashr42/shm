class CanBlockUser < ActiveRecord::Migration
  def up
    add_column :users, :timeout_block, :boolean, :default => false, :null => false
  end

  def down
    remove_column :users, :timeout_block
  end
end
