class Document < ActiveRecord::Base
  # Данная сущность является результатом какого-либо события

  belongs_to :event
end