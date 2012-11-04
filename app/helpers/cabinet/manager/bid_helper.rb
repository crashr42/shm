module Cabinet::Manager::BidHelper
  def user_bid_path bid
    url_for :controller => :'cabinet/manager/user', :action => :show, :id => PatientUser.find_by_email(bid.email).id
  end
end
