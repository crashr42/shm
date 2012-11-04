class BidMailer < ActionMailer::Base
  def created b
    mail(:from => 't@t.ru', :to => b.email, :subject => 'Bid created')
  end

  def rejected b
    mail(:from => 't@t.ru', :to => b.email, :subject => 'Bid rejected')
  end

  def approved b
    mail(:from => 't@t.ru', :to => b.email, :subject => 'Bid approved')
  end
end
