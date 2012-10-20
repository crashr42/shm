class Cabinet::Manager::ParameterController < Cabinet::ManagerController
  def index
    @parameters = Parameter.limit(20)
  end

  def new
  end

  def create
    @parameter = params[:parameter][:type].constantize.new params[:parameter]
    respond_to do |f|
      if @parameter.save
        f.html { redirect_to({:action => :index}, :notice => 'Parameter created.') }
      else
        f.html { render :action => :new }
      end
    end
  end

  def edit
    @parameter = Parameter.find params[:id]
  end

  def update
    @parameter = Parameter.find params[:id]
    respond_to do |f|
      if @parameter.update_attributes params[:parameter]
        f.html { redirect_to({:action => :index}, :notice => 'Parameter updated.') }
      else
        f.html { render :action => :edit }
      end
    end
  end
end
