class DiagnosticController < ApplicationController
  skip_before_filter :manage_user

  def parameter
    parameter_data = ParametersData.new(params[:data])
    respond_to do |f|
      if parameter_data.save
        f.json { render :json => {
            :message => 'parameter_data.saved'
        } }
      else
        f.json { render :json => {
            :message => 'parameter_data.saved.error',
            :errors => parameter_data.errors.messages
        }, :status => :unprocessable_entity }
      end
    end
  end
end
