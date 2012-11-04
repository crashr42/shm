class Cabinet::Manager::BidController < ApplicationController
  layout 'cabinet/manager/layout'

  def index
    @bids = Bid.limit(20)
  end

  def show
    @bid = Bid.find params[:id]
  end

  def approve
    @bid = Bid.find params[:id]

    respond_to do |f|
      if @bid.approve
        f.html { redirect_to({:action => :show, :id => @bid.id}, :notice => 'bid_approved') }
      else
        raise Exception
      end
    end
  end

  def reject
    @bid = Bid.find params[:id]

    respond_to do |f|
      if @bid.reject
        f.html { redirect_to({:action => :show, :id => @bid.id}, :notice => 'bid_rejected') }
      else
        raise Exception
      end
    end
  end
end
