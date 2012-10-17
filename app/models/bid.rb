class Bid < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :third_name, :address, :policy, :passport_scan
  mount_uploader :passport_scan, PassportScanUploader

  validates_length_of :first_name, :maximum => 255
  validates_length_of :last_name, :maximum => 255
  validates_length_of :third_name, :maximum => 255
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :address
  validates_presence_of :policy
  validates_presence_of :passport_scan

  def information
    "#{first_name} #{last_name} #{third_name} #{address}"
  end

  def reject
    write_attribute(:status, 'rejected')
    save!
  end

  def approve
    write_attribute(:status, 'approved')
    save!
  end

  def css_status
    case read_attribute(:status)
      when 'approved' then
        'success'
      when 'rejected' then
        'important'
      else
        'info'
    end
  end
end
