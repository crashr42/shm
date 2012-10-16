class BidController < ApplicationController
  def new
    @bid = Bid.new
  end

  def create
    bid = Bid.new params[:bid]

    respond_to do |f|
      if bid.save!
        f.html { redirect_to({:action => :show, :id => bid.id}, :notice => 'Bid created.') }
      else
        raise Exception
      end
    end
  end

  def show
    @bid = Bid.find params[:id]
  end
end
