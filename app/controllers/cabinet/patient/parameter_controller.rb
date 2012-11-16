class Cabinet::Patient::ParameterController < ApplicationController
  def index
    @parameters = User.current.parameters
  end

  def new

  end

  def create

  end
end
