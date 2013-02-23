class Cabinet::Patient::DocumentController < Cabinet::PatientController
  def show
    @document = Document.find(params[:id])
  end
end
