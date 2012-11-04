class BidMailer < ActionMailer::Base
  def created bid
    mail(:from => 't@t.ru', :to => bid.email, :subject => 'Bid created')
  end

  def rejected bid
    mail(:from => 't@t.ru', :to => bid.email, :subject => 'Bid rejected')
  end

  def approved patient
    @patient = patient
    mail(:from => 't@t.ru', :to => patient.email, :subject => 'Bid approved')
  end
end
