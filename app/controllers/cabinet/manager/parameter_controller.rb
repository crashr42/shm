class Cabinet::Manager::ParameterController < Cabinet::ManagerController
  def index
    @parameters = Parameter.limit(20)
  end

  def new
  end

  def create
    if params[:parameter][:type].present?
      p = params[:parameter][:type].constantize.new params[:parameter]
      p.save!
      redirect_to :action => :index
    else
      raise ArgumentError
    end
  end
end
