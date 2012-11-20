class Cabinet::Patient::ParameterController < Cabinet::PatientController
  def index
    @parameters = User.current.parameters
  end

  def edit
    @storage = ParametersData.new({:parameter_id => params[:id]})
  end

  def update
    @storage = ParametersData.new params[:parameters_data]
    @storage.user_id = current_user.id
    respond_to do |f|
      if @storage.save
        f.html { redirect_to({:action => :index}, :notice => 'Parameter updated.') }
      else
        f.html { render({:action => :edit}) }
      end
    end
  end
end
