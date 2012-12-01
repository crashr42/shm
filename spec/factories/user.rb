FactoryGirl.define do
  %w(user patient_user admin_user manager_user doctor_user).each do |r|
    factory r.to_sym do
      address 'test'
      email 'test@test.com'
      password '123456'
      first_name 'test'
      last_name 'test'
      type r.classify
    end
  end
end