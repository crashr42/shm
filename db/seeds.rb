require "faker"

ActiveRecord::Base.connection.execute('DELETE FROM roles_users')

Role.delete_all

Role.create :name => 'patient'
Role.create :name => 'doctor'
Role.create :name => 'admin'

User.delete_all

Rake::Task['users:add_test'].invoke

(0..50).each do
  u = User.new
  u.email = Faker::Internet.email
  u.password = Faker::Lorem.characters 15
  u.roles << Role.find_by_name('patient')
  u.save!
end

