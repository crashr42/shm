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
      raise Exception
    end
  end

  def edit
    @parameter = Parameter.find params[:id]
  end

  def update
    p = Parameter.find params[:id]

    respond_to do |f|
      if p.update_attributes params[:parameter]
        f.html {redirect_to :action => :index, :notice => 'Parameter updated.'}
      else
        raise Exception
      end
    end
  end
end
