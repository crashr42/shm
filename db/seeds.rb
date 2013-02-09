#encoding: utf-8

require 'faker'

UsersToRoles.delete_all
Role.delete_all
RecurrenceRule.delete_all
Attendee.delete_all
Document.delete_all
Event.delete_all
ParametersData.delete_all
ParametersToPatients.delete_all
Parameter.delete_all
RuleParameterInput.delete_all
User.delete_all
Diagnosis.delete_all
Specialty.delete_all
Bid.delete_all

Role.create :name => 'doctor'
Role.create :name => 'patient'
Role.create :name => 'admin'
Role.create :name => 'manager'

Specialty.create :name => 'Кардиолог'
Specialty.create :name => 'Ортопед'
Specialty.create :name => 'Логопед'
Specialty.create :name => 'Оттоларинголог'
Specialty.create :name => 'Окулист'

Diagnosis.create({
                     :class_code => 'I',
                     :class_name => 'Некоторые инфекционные и паразитарные болезни',
                     :block_code => 'A30-A49',
                     :block_name => 'Другие бактериальные болезни',
                     :code       => 'A39.5',
                     :code_name  => 'Менингококковая болезнь сердца'
                 })

Role.all.each do |role|
  user = "#{role.name.capitalize!}User".constantize.new
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.address = "#{Faker::Address.country} #{Faker::Address.city} #{Faker::Address.street_address}"
  if user.is_a? PatientUser
    user.policy = Faker::Lorem.characters 32
    user.doctor_user = DoctorUser.first
  end
  if user.is_a? DoctorUser
    user.specialty = Specialty.first(:offset => rand(Specialty.count))
  end
  user.email = "#{role.name.downcase}@shm.com"
  user.password = 123456
  user.save!
  UsersToRoles.create({:user => user, :role => role})
end

(0..10).each do
  u = DoctorUser.new
  u.first_name = Faker::Name.first_name
  u.last_name = Faker::Name.last_name
  u.address = "#{Faker::Address.country} #{Faker::Address.city} #{Faker::Address.street_address}"
  u.policy = Faker::Lorem.characters 32
  u.email = Faker::Internet.email
  u.password = u.email
  u.specialty = Specialty.first(:offset => rand(Specialty.count))
  u.save!
  UsersToRoles.create({:user => u, :role => Role.find_by_name('doctor')})
end

DoctorUser.all.each do |d|
  from_date = DateTime.now.to_date - Random.rand(1..10).days
  to_date = DateTime.now.to_date + Random.rand(1..10).days
  from_date.step(to_date).each do |date|
    e = AppointmentHourEvent.new
    e.summary = "Summary for appointment hour for user #{d.email}"
    e.description = "Description for appointment hour for user #{d.email}"
    e.date_start = date.to_datetime.change({:hour => Random.rand(8..12)})
    e.date_end = e.date_start.change({:hour => e.date_start.hour + Random.rand(1..6)})
    e.user = d
    e.save!

    AttendingDoctorAttendee.create({:user => d, :event => e})
  end
end

RuleParameterInput.create({:rule => '2 раза в день после еды'})
RuleParameterInput.create({:rule => '3 раза в день на голодный желудок'})
RuleParameterInput.create({:rule => 'утром'})
RuleParameterInput.create({:rule => 'вечером'})

BoolParameter.create({
                         :name => 'Головная боль',
                         :rule_parameter_input => RuleParameterInput.first(:offset => rand(RuleParameterInput.count))
                     })
IntegerParameter.create({:name => 'Температура', :metadata => {
    :default => '36',
    :validators => {
        :min => '0',
        :max => '100'
    }
}, :rule_parameter_input => RuleParameterInput.first(:offset => rand(RuleParameterInput.count))})
SelectParameter.create({:name => 'Возрастная категория', :metadata => {
    :default => '0-9',
    :values => %w(0-9 9-18 18-27 27-36)
}, :rule_parameter_input => RuleParameterInput.first(:offset => rand(RuleParameterInput.count))})
StringParameter.create({:name => '2х2', :metadata => {
    :default => '4'
}, :rule_parameter_input => RuleParameterInput.first(:offset => rand(RuleParameterInput.count))})

(0..50).each do
  u = PatientUser.new
  u.first_name = Faker::Name.first_name
  u.last_name = Faker::Name.last_name
  u.address = "#{Faker::Address.country} #{Faker::Address.city} #{Faker::Address.street_address}"
  u.policy = Faker::Lorem.characters 32
  u.email = Faker::Internet.email
  u.password = u.email
  u.doctor_user = DoctorUser.first(:offset => rand(DoctorUser.count))
  u.diagnosis = Diagnosis.first(:offset => rand(Diagnosis.count))
  u.save!
  UsersToRoles.create({:user => u, :role => Role.find_by_name('patient')})

  ParametersToPatients.create({:user_id => u.id, :parameter_id => BoolParameter.first.id})
  ParametersToPatients.create({:user_id => u.id, :parameter_id => IntegerParameter.first.id})
  ParametersToPatients.create({:user_id => u.id, :parameter_id => SelectParameter.first.id})
  ParametersToPatients.create({:user_id => u.id, :parameter_id => StringParameter.first.id})

  (0..10).each do
    ae = AppointmentEvent.first(:offset => rand(AppointmentEvent.count))
    ae.attendees.destroy_all

    PatientAttendee.create({:user => u, :event => ae})
    AttendingDoctorAttendee.create({:user => ae.attending_doctor, :event => ae})
  end
end

(0..10).each do
  b = Bid.new
  b.address = "#{Faker::Address.country} #{Faker::Address.city} #{Faker::Address.street_address}"
  b.email = Faker::Internet.email
  b.first_name = Faker::Name.first_name
  b.last_name = Faker::Name.last_name
  b.third_name = Faker::Name.last_name
  b.passport_scan = open("#{Rails.root}/spec/images/test.jpg")
  b.policy = Faker::Lorem.characters(5)
  b.save!
end

