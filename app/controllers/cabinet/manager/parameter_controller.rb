class Cabinet::Manager::ParameterController < Cabinet::ManagerController
  def index
    @parameters = Parameter.limit(20)
  end

  def new
    @parameter = Parameter.new
  end

  def create
    if params[:parameter][:type].present?
      p = params[:parameter][:type].constantize.new params[:parameter]
      #p.save!
      render :text => p.metadata.to_json
    end
  end
end
