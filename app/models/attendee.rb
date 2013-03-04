class Attendee < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  after_commit :publish, :on => :create

  validates :user_id, :presence => true
  validates :event_id, :presence => true

  attr_protected :id, :created_at, :updated_at

  def publish
    # Сообщаем всем участникам события что появился новый участник
    event.attendees.each { |a| a.user.push({:user => user, :event => event}, 'attendee.create') }
  end
end
