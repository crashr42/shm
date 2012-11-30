include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :bid do
    first_name    'test'
    last_name     'test'
    third_name    'test'
    address       'test'
    policy        '12345'
    email         'test@test.ru'
    passport_scan { fixture_file_upload(Rails.root.join('spec', 'images', 'test.png'), 'image/png') }
  end
end