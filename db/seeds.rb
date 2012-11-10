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

DoctorUser.all.each do |d|
  from_date = DateTime.now - Random.rand(1..10).days
  to_date = DateTime.now + Random.rand(1..10).days
  from_date.step(to_date).each do |date|
    e = AppointmentHourEvent.new
    e.summary = "Summary for appointment hour for user #{d.email}"
    e.description = "Description for appointment hour for user #{d.email}"
    e.date_start = date
    e.date_end = date
    e.time_start = e.date_start.to_time
    e.time_end = e.time_start + Random.rand(1..8).hours
    e.user = d
    e.save!

    a = Attendee.new
    a.event = e
    a.user = d
    a.role = 'attending_doctor'
    a.save!
  end
end

(0..50).each do
  u = PatientUser.new
  u.first_name = Faker::Name.first_name
  u.last_name = Faker::Name.last_name
  u.address = "#{Faker::Address.country} #{Faker::Address.city} #{Faker::Address.street_address}"
  u.policy = Faker::Lorem.characters 32
  u.email = Faker::Internet.email
  u.password = u.email
  u.doctor_user = DoctorUser.first(:offset => rand(DoctorUser.count))
  u.save!
  ur = UsersToRoles.new
  ur.user = u
  ur.role = Role.find_by_name 'patient'
  ur.save!

  (0..10).each do
    appointment_event = AppointmentEvent.first(:offset => rand(AppointmentEvent.count))
    appointment_event.attendees.delete_all

    a = Attendee.new
    a.event = appointment_event
    a.user = u
    a.role = 'patient'
    a.save!

    a = Attendee.new
    a.event = appointment_event
    a.user = appointment_event.event.attendees.where(:role => 'attending_doctor').first.user
    a.role = 'attending_doctor'
    a.save!
  end
end