class Cabinet::Doctor::DiagnosticController < Cabinet::DoctorController
  def show
    @patient = PatientUser.find(params[:id])
  end

  def data
    from = Time.at(params[:from].to_i)
    to   = Time.at(params[:to].to_i)

    respond_to do |f|
      f.json { render :json => ParametersData.diagnostic(params[:patient_id], params[:parameter_id], from, to) }
    end
  end
end
