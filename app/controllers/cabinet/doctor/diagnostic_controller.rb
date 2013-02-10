class Cabinet::Doctor::DiagnosticController < Cabinet::DoctorController
  def show
    @patient = PatientUser.find(params[:id])
  end

  def chart
    from = Time.at(params[:from].to_i)
    to = Time.at(params[:to].to_i)

    respond_to do |f|
      f.json { render json: ChartFactory.build(params[:patient_id], params[:parameter_id], from, to) }
    end
  end

  def raw
    from = Time.at(params[:from].to_i)
    to = Time.at(params[:to].to_i)
    @data = DiagnosticFactory.raw(params[:patient_id], params[:parameter_id], from, to)
  end
end
