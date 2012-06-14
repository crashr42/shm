namespace :users do
  task :add_test => :environment do
    u = User.new
    u.email = "test@shm.com"
    u.password = "123456"
    u.save!
  end
end