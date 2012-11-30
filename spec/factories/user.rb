FactoryGirl.define do
  factory :user do
    address 'test'
    email 'test@test.com'
    password '123456'
    type 'User'
    first_name 'test'
    last_name 'test'
  end
end