class EventMailer < ActionMailer::Base
  # Рассылка сообщений всем участникам события о том что пользователь отписался от события.
  # === Example
  # EventMailer.unsubscribe event, user
  # === Arguments
  # [event]
  #   Событие от которого отписался пользователь.
  # [user]
  #   Пользователь который отписался от события.
  def unsubscribe event, user
    @user = user
    event.attendees.each do |a|
      mail(:from => 't@t.ru', :to => a.user.email, :subject => 'User unsubscribe')
    end
  end
end
