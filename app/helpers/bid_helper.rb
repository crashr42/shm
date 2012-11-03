module BidHelper
  @@status_to_css = {
    :approved => 'success',
    :rejected => 'important',
    :created  => 'info'
  }

  def approved_path b
    url_for :controller => :'cabinet/manager/bid', :action => :approve, :id => b.id
  end
  
  def rejected_path b
    url_for :controller => :'cabinet/manager/bid', :action => :reject, :id => b.id
  end

  def status_label b
    content_tag :span, b.status, :class => "label label-#{@@status_to_css[b.status.to_sym]}"
  end
end
