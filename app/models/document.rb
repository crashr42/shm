class Document < ActiveRecord::Base
  # Создатель документа
  belongs_to :user
  # Событие к которому привязан документ
  belongs_to :event

  attr_accessible :event_id

  validates :user_id, :presence => true

  # Назначем создателем события текущего авторизованного пользователя
  before_create do
    if User.current.present?
      self.user_id = User.current.id
    end
  end
end
