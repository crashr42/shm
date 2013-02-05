require 'spec_helper'

describe DiagnosticController do
  it 'should be save parameter data from post request' do
    patient = create(:patient_user)
    parameter = create(:bool_parameter)

    request.accept = 'application/json'
    post :parameter, {:data => {:user_id => patient.id, :parameter_id => parameter.id, :value => true}}, :format => :json
    response.should be_success
  end
end