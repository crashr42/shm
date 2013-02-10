class BoolDiagnostic
  def self.chart(patient_id, parameter_id, from, to)
    values = [0, 0]
    ParametersData.where({
        :user_id => patient_id,
        :parameter_id => parameter_id
    }).where('created_at between ? and ?', from.to_datetime, to.to_datetime).order(:created_at).map { |p|
      p.value == 'false' ? values[0] += 1 : values[1] += 1
    }
    values
  end

  def self.raw(patient_id, parameter_id, from, to)
    ParametersData.where({
        :user_id => patient_id,
        :parameter_id => parameter_id
    }).where('created_at between ? and ?', from.to_datetime, to.to_datetime).order(:created_at)
  end
end