class Cabinet::Manager::ParameterController < Cabinet::ManagerController
  def index
    @parameters = Parameter.limit(20)
  end

  def new
  end

  def create

  end
end
