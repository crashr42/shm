require "faker"

ActiveRecord::Base.connection.execute('DELETE FROM users_to_roles')

Role.delete_all

Role.create :name => 'patient'
Role.create :name => 'doctor'
Role.create :name => 'admin'
Role.create :name => 'manager'

User.delete_all

Rake::Task['users:add_test'].invoke

Role.all.each do |role|
  user = User.new
  user.email = "#{role.name.downcase}@shm.com"
  user.password = 123456
  user.save!
  ur = UsersToRoles.new
  ur.user = user
  ur.role = role
  ur.save
end

(0..50).each do
  u = User.new
  u.email = Faker::Internet.email
  u.password = Faker::Lorem.characters 15
  u.save!
  ur = UsersToRoles.new
  ur.user = u
  ur.role = Role.find_by_name 'patient'
  ur.save!
end

