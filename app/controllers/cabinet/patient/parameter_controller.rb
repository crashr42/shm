class Cabinet::Patient::ParameterController < Cabinet::PatientController
  def index
    @parameters = User.current.parameters
  end

  def create
    @storage = ParametersData.new params[:storage]
    @storage.user_id = current_user.id
    respond_to do |f|
      if @storage.save
        f.json { render :json => {
            :message => 'parameter_data.saved'
        } }
      else
        f.json { render :json => {
            :message => 'parameter_data.saved.error',
            :errors => @storage.errors.messages
        }, :status => :unprocessable_entity }
      end
    end
  end
end
