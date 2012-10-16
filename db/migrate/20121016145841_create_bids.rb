class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.string      :first_name,    :null => false
      t.string      :last_name,     :null => false
      t.string      :third_name,    :null => true
      t.string      :address,       :null => false
      t.string      :policy,        :null => false
      t.string      :passport_scan, :null => false
      t.string      :status,        :null => false, :default => 'created'
      t.timestamps
    end
  end
end
