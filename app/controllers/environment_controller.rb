class EnvironmentController < ApplicationController
  def rails
    respond_to do |f|
      f.js { render :layout => false }
    end
  end
end
