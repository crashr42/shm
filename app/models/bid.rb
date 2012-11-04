class Bid < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :third_name, :address, :policy, :passport_scan, :email
  mount_uploader :passport_scan, PassportScanUploader

  validates :first_name, :length => {:maximum => 255, :minimum => 1}, :presence => true
  validates :last_name,  :length => {:maximum => 255, :minimum => 1}, :presence => true
  validates :third_name, :length => {:maximum => 255, :minimum => 1}
  validates :address,    :length => {:maximum => 255, :minimum => 1}, :presence => true
  validates :policy,     :length => {:maximum => 32, :minimum => 32}, :presence => true
  validates :email,      :length => {:minimum => 5}, :presence => true, :email => true
  validates :passport_scan, :presence => true

  after_create :mail_bid_created

  def mail_bid_created
    BidMailer::created(self).deliver
  end

  def information
    "#{first_name} #{last_name} #{third_name} #{address}"
  end

  def reject
    write_attribute(:status, 'rejected')
    save!
    BidMailer::rejected(self).deliver
  end

  def approve
    write_attribute(:status, 'approved')
    save!

    p = PatientUser.new
    p.first_name = self.first_name
    p.last_name = self.last_name
    p.third_name = self.third_name
    p.email = self.email
    p.address = self.address
    p.policy = self.policy
    p.password = Faker::Lorem.characters 16
    p.reset_password_token = Faker::Lorem.characters 32
    p.reset_password_sent_at = DateTime.now
    p.roles << Role.find_by_name('patient')
    p.save!

    BidMailer::approved(p).deliver
  end

  def rejected?
    read_attribute(:status) == 'rejected'
  end

  def approved?
    read_attribute(:status) == 'approved'
  end

  def created?
    read_attribute(:status) == 'created'
  end
end
