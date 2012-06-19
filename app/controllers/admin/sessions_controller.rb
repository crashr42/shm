class Admin::SessionsController < Devise::SessionsController

  def create
    super

    if user_signed_in?
      #redirect_to :controller =>
    end
  end

end
