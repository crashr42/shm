class Cabinet::Doctor::DiagnosticController < Cabinet::DoctorController
  def show
    @patient = PatientUser.find(params[:id])
  end

  def data
    from = Time.at(params[:from].to_i)
    to   = Time.at(params[:to].to_i)

    respond_to do |f|
      f.json { render :json => ParametersData.where({
          :user_id      => params[:patient_id],
          :parameter_id => params[:parameter_id]
      }).where('created_at between ? and ?', from.to_datetime, to.to_datetime).order(:created_at).map { |p|
        [p.created_at.to_i * 1000, p.value.to_i]
      } }
    end
  end
end
