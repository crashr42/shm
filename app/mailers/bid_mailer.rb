class BidMailer < ActionMailer::Base
  def created
    mail(:from => 't@t.ru', :to => 'l@l.ru', :subject => 'ttt')
  end

  def rejected
    mail(:from => 't@t.ru', :to => 'l@l.ru', :subject => 'ttt')
  end

  def approved
    mail(:from => 't@t.ru', :to => 'l@l.ru', :subject => 'ttt')
  end
end
