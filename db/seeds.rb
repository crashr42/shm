require "faker"

UsersToRoles.delete_all
Role.delete_all
RecurrenceRule.delete_all
Attendee.delete_all
Document.delete_all
Event.delete_all
User.delete_all
Bid.delete_all

Role.create :name => 'doctor'
Role.create :name => 'patient'
Role.create :name => 'admin'
Role.create :name => 'manager'

Role.all.each do |role|
  user = "#{role.name.capitalize!}User".constantize.new
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.address = "#{Faker::Address.country} #{Faker::Address.city} #{Faker::Address.street_address}"
  if user.is_a? PatientUser
    user.policy = Faker::Lorem.characters 32
    user.doctor_user = DoctorUser.first
  end
  user.email = "#{role.name.downcase}@shm.com"
  user.password = 123456
  user.save!
  ur = UsersToRoles.new
  ur.user = user
  ur.role = role
  ur.save!
end

(0..10).each do
  u = DoctorUser.new
  u.first_name = Faker::Name.first_name
  u.last_name = Faker::Name.last_name
  u.address = "#{Faker::Address.country} #{Faker::Address.city} #{Faker::Address.street_address}"
  u.policy = Faker::Lorem.characters 32
  u.email = Faker::Internet.email
  u.password = u.email
  u.save!
  ur = UsersToRoles.new
  ur.user = u
  ur.role = Role.find_by_name 'doctor'
  ur.save!
end

(0..50).each do
  u = PatientUser.new
  u.first_name = Faker::Name.first_name
  u.last_name = Faker::Name.last_name
  u.address = "#{Faker::Address.country} #{Faker::Address.city} #{Faker::Address.street_address}"
  u.policy = Faker::Lorem.characters 32
  u.email = Faker::Internet.email
  u.password = u.email
  u.save!
  ur = UsersToRoles.new
  ur.user = u
  ur.role = Role.find_by_name 'patient'
  ur.save!

  (0..30).each do |i|
    e = Event.new
    e.category = Event.categories.sample
    e.summary = "Summary for event #{i} by user #{u.email}"
    e.description = "Description for event #{i} by user #{u.email}"
    e.date_start = DateTime.now - Random.rand(1..10).days
    e.time_start = e.date_start.to_time
    e.date_end = e.date_start + Random.rand(1..3).days
    e.time_end = e.date_end.to_time

    (0..Random.rand(0..2)).each do |ir|
      r = RecurrenceRule.new
      r.count = Random.rand(0..10)
      r.end_date = DateTime.now + Random.rand(1..7200).minutes
      r.frequency = :yearly
      r.hours = Random.rand(0...24)
      r.interval = 1
      r.minutes = Random.rand(0...60)
      r.month_days = Random.rand(1...31)
      r.months = Random.rand(1...12)
      r.seconds = Random.rand(0...60)
      r.event = e
      r.save!
    end
    e.user = u
    e.save!

    a = Attendee.new
    a.event = e
    a.user = User.first(:offset => rand(User.count))
    a.role = Attendee.roles[rand(3)]
    a.save!
  end
end

PatientUser.all.each do |p|
  p.doctor_user = DoctorUser.first(:offset => rand(DoctorUser.count))
  p.save!
end