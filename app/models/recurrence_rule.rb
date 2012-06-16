class RecurrenceRule < ActiveRecord::Base
  belongs_to :event

  attr_accessible :count, :end_date, :frequency, :interval, :week_start

  %w{
    seconds minutes hours week_days
    month_days year_days weeks months position
  }.each do |p|
    define_method "add_#{p.chomp('s')}" do |value|
      eval """
        self.#{p} = '' unless self.#{p}
        unless self.#{p}.split(',').include?(#{value}.to_s)
          self.#{p} = self.#{p}.split(',').push(#{value}).join(',')
        end
      """
    end

    define_method "remove_#{p.chomp('s')}" do |value|
      eval """
        self.#{p} = '' unless self.#{p}
        s = self.#{p}.split(',')
        s.delete(#{value}.to_s)
        self.#{p} = s == '' ? nil : s.join(',')
      """
    end
  end

end
