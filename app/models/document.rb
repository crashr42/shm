class Document < ActiveRecord::Base
  # attr_accessible :title, :body

  #That user is who by create current document. The attendees reference with document by entity "Event"
  belongs_to :user

  #The event that reference current document
  belongs_to :event
end
