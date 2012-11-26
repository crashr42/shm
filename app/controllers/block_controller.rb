class BlockController < ApplicationController
  layout 'block'
  skip_before_filter :timeout_block, :current_url

  def new
    current_user.timeout_blocked
  end

  def destroy
    if current_user.valid_password?(params[:password])
      current_user.timeout_unblocked
      redirect_to cookies[:current_url] || root_path
    else
      redirect_to({:action => :new}, :error => 'invalid.password')
    end
  end
end
