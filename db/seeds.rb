require "faker"

User.delete_all

Rake::Task['users:add_test'].invoke

(0..50).each do
  u = User.new
  u.email = Faker::Internet.email
  u.password = Faker::Lorem.characters 15
  u.save!
end

