class Cabinet::Doctor::ParameterController < Cabinet::DoctorController
  def link
    l = ParametersToPatients.new({:user_id => params[:patient_id], :parameter_id => params[:parameter_id]})
    respond_to do |f|
      if l.save
        f.json { render :json => {
            :message => 'parameter.link'
        } }
      else
        f.json { render :json => {
            :message => 'parameter.link.error',
            :errors => l.errors.messages
        }, :status => :unprocessable_entity }
      end
    end
  end

  def unlink
    l = ParametersToPatients.where(:user_id => params[:patient_id]).where(:parameter_id => params[:parameter_id]).first
    respond_to do |f|
      if l.destroy.destroyed?
        f.json { render :json => {
            :message => 'parameter.unlink'
        } }
      else
        f.json { render :json => {
            :message => 'parameter.unlink.error',
            :errors => l.errors.messages
        }, :status => :unprocessable_entity }
      end
    end
  end
end
