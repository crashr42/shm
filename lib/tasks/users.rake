namespace :users do
  task :add_test => :environment do
    Role.create :name => 'admin' unless Role.find_by_name 'admin'

    if User.find_by_email('test@shm.com')
      puts 'Admin test@shm.com 123456 already exists.'
    else
      u = User.new
      u.email = "test@shm.com"
      u.password = "123456"
      u.save!
      ur = UsersToRoles.new
      ur.user = u
      ur.role = Role.find_by_name('admin')
      ur.save!
      puts 'Admin test@shm.com 123456 created.'
    end
  end
end