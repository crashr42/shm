class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_many :roles, :through => :users_to_roleses, :readonly => false
  has_many :users_to_roleses, :class_name => UsersToRoles, :dependent => :delete_all
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

 
  def self.searh_patients_by_name search_name
    @users = User.where(
    'first_name ILIKE :name or last_name ILIKE :name', {:name => "%#{search_name}%"}).where('type = ?', "PatientUser").limit(200)

  end
  
  #find doctor
  def self.searh_doctors_by_name search_name
    @users = User.where(
    'first_name ILIKE :name or last_name ILIKE :name', {:name => "%#{search_name}%"}).where('type = ?', "DoctorUser").limit(200)
  
  end

  def self.searh_patients_by_email search_name
    @users = User.where(
    'email ILIKE :name', {:name => "%#{search_name}%"}).where('type = ?', "PatientUser").limit(200)

  end
  
  #find doctor
  def self.searh_doctors_by_email search_name
    @users = User.where(
    'email first_name ILIKE :name', {:name => "%#{search_name}%"}).where('type = ?', "DoctorUser").limit(200)
  
  end

end
