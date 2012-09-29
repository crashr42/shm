class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :users_to_roleses, :class_name => 'UsersToRoles'
  has_many :roles, :through => :users_to_roleses, :readonly => false
  has_many :calendars
  has_many :events

  attr_protected :created_at, :current_sign_in_at, :current_sign_in_ip, :encrypted_password,
                 :id, :last_sign_in_at, :last_sign_in_ip, :remember_created_at,
                 :reset_password_sent_at, :reset_password_token, :sign_in_count, :updated_at, :users_to_roleses

  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end

  def role?(name)
    self.roles.find_by_name(name)
  end

  # заглушка - релизовать согласно задаче #26 Поиск подходящих событий
  def find_events_by_date(date)
    events.where('date_start between ? and ?', DateTime.parse("#{date.year}-#{date.month}-#{date.day} 00:00:00"), DateTime.parse("#{date.year}-#{date.month}-#{date.day} 23:59:59 order by date_start"))
  end
end
