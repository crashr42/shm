class AddAttendingDoctorForPatient < ActiveRecord::Migration
  def up
    add_column :users, :doctor_user_id, :int, :null => true
    add_foreign_key :users, :users, :column => :doctor_user_id
  end

  def down
    remove_column :users, :doctor_user_id
  end
end
