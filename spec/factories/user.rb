FactoryGirl.define do
  %w(user patient admin manager doctor).each do |r|
    factory "#{r}_user".to_sym do
      address 'test'
      email 'test@test.com'
      password '123456'
      first_name 'test'
      last_name 'test'
      type "#{r.capitalize}User"
    end
  end
end