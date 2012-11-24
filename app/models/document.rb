class Document < ActiveRecord::Base
  attr_accessible :event_id

  #That user is who by create current document. The attendees reference with document by entity "Event"
  belongs_to :user

  #The event that reference current document
  belongs_to :event

  private
  def initialize_creator_user
    self.user_id = User.current.id
  end
end
